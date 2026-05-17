# environments/aws/development/terraform.tfvars

ambiente = "dev"
vpc_cidr = "10.0.0.0/16"

# Subnets que terão acesso direto da rua (Internet)
subnets_publicas = {
  "internet" = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "sa-east-1a"
  }
  "vpn" = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "sa-east-1b"
  }
}
subnets_privadas = {
  "database-1" = {
    cidr_block        = "10.0.3.0/24"
    availability_zone = "sa-east-1a"
  }
  "clientes-1" = {
    cidr_block        = "10.0.4.0/24"
    availability_zone = "sa-east-1b"
  }
}

imagens_disponiveis = {
  "ubuntu_22"    = "ami-01c4e7f7d9a667a59"
  "amazon_linux" = "ami-06930b0cd4de115a5"
}

# DECLARAÇÃO DE TODAS AS MÁQUINAS DO SEU SUPORTE:
config_maquinas = {
  "web" = {
    nome_vm             = "webserver"
    so                  = "ubuntu_22"
    instance_type       = "t3.micro"
    subnet_nome         = "internet" # Essa vai morar na subnet pública
    tamanho_disco_extra = 10
  },
  "api" = {
    nome_vm             = "app-api"
    so                  = "amazon_linux"
    instance_type       = "t3.micro"
    subnet_nome         = "vpn" # Essa vai morar na outra subnet/AZ
    tamanho_disco_extra = 20
  }
}

databases = {
  "vendas" = {
    engine                  = "postgres"
    instance_class = "db.t4g.micro"
    identifier                  = "vendas"
    engine_version          = "18"
    database_name           = "mydb"
    allocated_storage = 20
    username         = "veendas_admin"
    password         = "must_be_eight_characters"
    backup_retention_period = 0
    skip_final_snapshot = true
    final_snapshot_identifier = null
    parameter_groups_name    = "default:postgres-18"
    db_subnet_group_name            = ["database-1"]

  }
  "ensino" = {
    engine                  = "mysql"
    allocated_storage = 20
    identifier                  = "ensino"
    instance_class = "db.t4g.micro"
    engine_version          = "8.0"
    database_name           = "mydb2"
    skip_final_snapshot = true
    final_snapshot_identifier = null
    username         = "admin"
    password         = "must_be_eight_characters"
    backup_retention_period = 0
    db_subnet_group_name            = ["database-1"]
  }
}
