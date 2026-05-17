# environments/aws/development/outputs.tf

output "vpc_id" {
  value       = module.networking.vpc_id
  description = "O ID da VPC criada no ambiente de Desenvolvimento em São Paulo"
}

output "public_subnet_ids" {
  value       = module.networking.public_subnet_ids
  description = "Mapa contendo os nomes e IDs de todas as subnets públicas criadas"
}


