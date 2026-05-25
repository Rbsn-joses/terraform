# Cria todos os usuários listados no tfvars
resource "aws_iam_user" "usuarios" {
  for_each = var.iam_users
  name     = each.key
}

resource "aws_iam_user_group_membership" "vinculo" {
  for_each = var.iam_users

  user   = aws_iam_user.usuarios[each.key].name
  groups = each.value.groups
}