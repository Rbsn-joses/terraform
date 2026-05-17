# variables.tf

variable "ambiente" {
  description = "O ambiente onde os recursos serão provisionados (ex: desenvolvimento, produção)"
  type        = string
}

variable "tags" {
  description = "Tags comuns aplicadas a todos os recursos"
  type        = map(string)
  default     = {}
}

# MAPA DINÂMICO PARA MÚLTIPLOS LAMBDAS
variable "lambdas" {
  description = "Mapa contendo as configurações de cada função Lambda"
  type = map(object({
    function_name        = string
    runtime              = string
    handler              = string
    role_name            = string
    iam_service_principal = string
    
    # Configurações do arquivo/empacotamento do código
    archive_type         = string
    source_path          = string
    output_path          = string
  }))
}