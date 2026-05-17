# environments/aws/development/main.tf

# tentando mudar nome do modulo sem ele deletar as subnets
# moved {
#   from = module.rede_brasil
#   to   = module.networking
# }
module "networking" {
  source = "../../../modulos/aws/networking"

  ambiente         = var.ambiente
  vpc_cidr         = var.vpc_cidr
  subnets_publicas = var.subnets_publicas
  subnets_privadas = var.subnets_privadas
}

module "computing" {
  source = "../../../modulos/aws/computing"

  ambiente = var.ambiente
  tags     = var.tags

  # Lógica para converter nomes legíveis do tfvars em IDs de AMIs e Subnets reais da AWS:
  maquinas = { for chave, vm in var.config_maquinas : chave => {
    nome_vm             = vm.nome_vm
    instance_type       = vm.instance_type
    tamanho_disco_extra = vm.tamanho_disco_extra
    
    # Busca o ID da AMI baseado no catálogo do tfvars
    ami_id              = var.imagens_disponiveis[vm.so]
    
    # Busca dinamicamente o ID da subnet gerado pelo módulo de redes
    subnet_id           = module.networking.public_subnet_ids[vm.subnet_nome]
  }}
}

module "database" {
  source = "../../../modulos/aws/database"

  ambiente = var.ambiente
  tags     = var.tags
  databases = { for chave, databse in var.databases : chave => {
    engine                  = databse.engine
    instance_class          = databse.instance_class
    engine_version          = databse.engine_version
    allocated_storage = databse.allocated_storage
    identifier                  = databse.identifier
    skip_final_snapshot = databse.skip_final_snapshot
    final_snapshot_identifier = databse.final_snapshot_identifier
    database_name           = databse.database_name
    username         = databse.username
    password         = databse.password
    backup_retention_period = databse.backup_retention_period
    db_subnet_group_name            = values(module.networking.database_subnet_ids)
  }}
}