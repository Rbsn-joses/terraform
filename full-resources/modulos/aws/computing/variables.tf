# modules/aws/computing/variables.tf

variable "ambiente" { type = string }

# Um mapa onde cada chave é o identificador da máquina
variable "maquinas" {
  type = map(object({
    nome_vm             = string
    ami_id              = string
    instance_type       = string
    subnet_id           = string
    tamanho_disco_extra = number
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}