# modules/aws/networking/outputs.tf

output "vpc_id" { value = aws_vpc.main.id }

output "public_subnet_ids" {
  value = { for k, v in aws_subnet.public : k => v.id }
}

output "database_subnet_ids" {
  value       = { for k, v in aws_subnet.database : k => v.id }
  description = "IDs das subnets privadas criadas para os bancos de dados"
}