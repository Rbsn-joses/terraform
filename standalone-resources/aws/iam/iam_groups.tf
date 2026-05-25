# 1. Cria os Grupos do IAM usando as chaves do tfvars (admin, desenvolvedores, suporte)
resource "aws_iam_group" "grupos" {
  for_each = var.iam_groups
  name     = each.value.group_name
}

# -------------------------------------------------------------------
# ANEXAR POLÍTICAS PADRÃO DA AWS
# -------------------------------------------------------------------
locals {
  aws_policies_flat = flatten([
    for group_key, group_data in var.iam_groups : [
      for policy_arn in group_data.policies_arn : {
        group_key  = group_key
        policy_arn = policy_arn
      }
    ]
  ])
}

resource "aws_iam_group_policy_attachment" "aws_managed_attach" {
  for_each = { for pair in local.aws_policies_flat : "${pair.group_key}-${pair.policy_arn}" => pair }

  # CORREÇÃO: Aponta exatamente para a chave do recurso criado no passo 1
  group      = aws_iam_group.grupos[each.value.group_key].name
  policy_arn = each.value.policy_arn
}

# -------------------------------------------------------------------
# ANEXAR POLÍTICAS CUSTOMIZADAS (As criadas no seu iam_policies.tf)
# -------------------------------------------------------------------
locals {
  custom_policies_flat = flatten([
    for group_key, group_data in var.iam_groups : [
      for policy_key in group_data.custom_policies_keys : {
        group_key  = group_key
        policy_key = policy_key
      }
    ]
  ])
}

resource "aws_iam_group_policy_attachment" "custom_attach" {
  for_each = { for pair in local.custom_policies_flat : "${pair.group_key}-${pair.policy_key}" => pair }

  # CORREÇÃO: Vincula a política customizada ao grupo correto usando a chave do map
  group      = aws_iam_group.grupos[each.value.group_key].name
  policy_arn = aws_iam_policy.custom_policies[each.value.policy_key].arn
}