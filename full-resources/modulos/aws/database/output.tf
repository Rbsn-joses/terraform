# modulos/aws/database/output.tf

output "cluster_identifiers" {
  value       = { for k, cluster in aws_db_instance.database : k => cluster.id }
  description = "Mapa com os identificadores de cada cluster de banco de dados"
}

output "engines" {
  value       = { for k, cluster in aws_db_instance.database : k => cluster.engine }
  description = "Mapa com os motores (engine) de cada cluster"
}


output "database_names" {
  value       = { for k, cluster in aws_db_instance.database : k => cluster.db_name }
  description = "Nomes dos bancos de dados iniciais"
}

output "master_usernames" {
  value       = { for k, cluster in aws_db_instance.database : k => cluster.username }
  description = "Usuários master de cada banco de dados"
}

output "backup_retention_periods" {
  value       = { for k, cluster in aws_db_instance.database : k => cluster.backup_retention_period }
  description = "Períodos de retenção de backup de cada cluster"
}


# EXTRA: Adicionei o endpoint de conexão, que você vai precisar para conectar as suas EC2 ao banco!
output "endpoints" {
  value       = { for k, cluster in aws_db_instance.database : k => cluster.endpoint }
  description = "Endpoints de conexão para as aplicações utilizarem"
}