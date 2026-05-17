output "lambda_function_arn" {
  description = "ARN da Função Lambda criada"
  value       = { for k, lambda in aws_lambda_function.my_lambda : k => lambda.arn }
}
output "lambda_function_names" {
  description = "Nomes de todas as funções Lambda provisionadas"
  value       = { for k, lambda in aws_lambda_function.my_lambda : k => lambda.function_name }
}

output "lambda_function_runtimes" {
  description = "Runtimes de todas as funções Lambda provisionadas"
  value       = { for k, lambda in aws_lambda_function.my_lambda : k => lambda.runtime }
}