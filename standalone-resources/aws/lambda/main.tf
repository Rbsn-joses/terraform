# 1. Cria o arquivo ZIP automaticamente para cada código cadastrado
data "archive_file" "lambda_zip" {
  for_each    = var.lambdas
  type        = each.value.archive_type
  source_file = each.value.source_path # Se for uma pasta, mude este argumento para 'source_dir'
  output_path = each.value.output_path
}

# 2. Cria uma Role de execução do IAM para cada Lambda de forma isolada
resource "aws_iam_role" "lambda_role" {
  for_each = var.lambdas
  name     = "${each.value.role_name}-${var.ambiente}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = each.value.iam_service_principal
        }
      }
    ]
  })

  tags = merge(
    { Name = "role-${each.key}-${var.ambiente}" },
    var.tags
  )
}

# 3. Permite que cada uma das Roles crie logs no CloudWatch
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  for_each   = var.lambdas
  role       = aws_iam_role.lambda_role[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# 4. Recurso principal que provisiona as Múltiplas Funções Lambda
resource "aws_lambda_function" "my_lambda" {
  for_each      = var.lambdas
  
  filename      = data.archive_file.lambda_zip[each.key].output_path
  function_name = "${each.value.function_name}-${var.ambiente}"
  role          = aws_iam_role.lambda_role[each.key].arn
  handler       = each.value.handler
  runtime       = each.value.runtime

  # Garante que o Lambda seja atualizado na AWS sempre que o arquivo local mudar de conteúdo
  source_code_hash = data.archive_file.lambda_zip[each.key].output_base64sha256

  tags = merge(
    { Name = "lambda-${each.key}-${var.ambiente}" },
    var.tags
  )
}