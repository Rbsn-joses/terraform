# Cria as políticas customizadas dinamicamente com base no tfvars
resource "aws_iam_policy" "custom_policies" {
  for_each    = var.custom_policies
  
  name        = each.value.name
  description = each.value.description

  policy = each.value.policy
}