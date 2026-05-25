output "usuarios" {
  description = "Lista o nome de usuário mapeado para o seu respectivo ARN no IAM"
  value       = { for k, v in aws_iam_user.usuarios : k => v.arn }
}

output "grupos" {
  description = "Lista a chave do grupo mapeada para o seu respectivo ARN no IAM"
  value       = { for k, v in aws_iam_group.grupos : k => v.arn }
}

output "grupo_member" {
  description = "mostra os membros do grupo"
  value =  { for k,v in aws_iam_user_group_membership.vinculo : k => v.groups }
}