variable "ambiente" {
  type        = string
  description = "Ambiente onde os recursos rodam (dev, prod, core)"
}

variable "emails_notificacao" {
  type        = list(string)
  description = "E-mails que receberão todos os alertas"
}

variable "budgets" {
  type = map(object({
    budget_type  = string # COST, RI_UTILIZATION, SAVINGS_PLANS_UTILIZATION
    limit_amount = string # Valor em USD ou em PERCENTAGE
    limit_unit   = string # USD ou PERCENTAGE
    time_unit    = string # MONTHLY, DAILY, QUARTERLY

    # Filtros opcionais para tornar o recurso customizável
    servicos_filtrados = optional(list(string), [])
    tag_chave          = optional(string, null)
    tag_valor          = optional(string, null) 
    notification_threshold            = optional(number, 80)
    forecasted_notification_threshold = optional(number, 100)
  }))
  description = "Mapa de configurações para múltiplos tipos de budgets"
}