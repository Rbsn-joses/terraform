# environments/aws/development/variables.tf

variable "ambiente" { type = string }
variable "vpc_cidr" { type = string }

# Substitua a antiga "subnets" por estas duas:
variable "subnets_publicas" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "subnets_privadas" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}


variable "imagens_disponiveis" { type = map(string) }

# Configuração que vai definir as máquinas do ambiente
variable "config_maquinas" {
  type = map(object({
    nome_vm             = string
    so                  = string # ubuntu_22, amazon_linux, etc.
    instance_type       = string
    subnet_nome         = string # public-1, public-2, etc.
    tamanho_disco_extra = number
  }))
}

variable databases {
    type = map(object({
    engine                  = string
    engine_version = string
    identifier                  = string
    instance_class          = string
    database_name           = string
    username         = string
    password         = string
    backup_retention_period = number
    skip_final_snapshot = bool
    final_snapshot_identifier = string
    allocated_storage = number

    db_subnet_group_name            = list(string)

}))
}

variable "tags" {
  type        = map(string)
  description = "Tags padrão para os recursos do módulo"
  default     = {
    Environment = "non-prod"
    centro-custo = "infraestrutura"
    projeto = "sre"
  }
}