resource "aws_budgets_budget" "gerenciador" {
  for_each = var.budgets

  name         = "budget-${each.key}-${var.ambiente}"
  budget_type  = each.value.budget_type
  limit_amount = each.value.limit_amount
  limit_unit   = each.value.limit_unit
  time_unit    = each.value.time_unit

  # FILTRO 1: Aplica se houver serviços específicos declarados
  dynamic "cost_filter" {
    for_each = length(each.value.servicos_filtrados) > 0 ? [1] : []
    content {
      name   = "Service"
      values = each.value.servicos_filtrados
    }
  }

  # FILTRO 2: Aplica se houver chave e valor de tag declarados
  dynamic "cost_filter" {
    for_each = each.value.tag_chave != null && each.value.tag_valor != null ? [1] : []
    content {
      name   = "TagKeyValue"
      values = ["user:${each.value.tag_chave}$${each.value.tag_valor}"] # Sintaxe AWS: user:Chave$Valor
    }
  }

  # NOTIFICAÇÃO PADRÃO: Alerta se atingir 80% do limite (Real)
  notification {
    comparison_operator        = each.value.budget_type == "COST" ? "GREATER_THAN" : "LESS_THAN"
    threshold                  = each.value.notification_threshold != null ? each.value.notification_threshold : 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = var.emails_notificacao
  }

  # NOTIFICAÇÃO DE PREVISÃO (Apenas para Budgets de Custo)
  dynamic "notification" {
    for_each = each.value.budget_type == "COST" ? [1] : []
    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = each.value.forecasted_notification_threshold != null ? each.value.forecasted_notification_threshold : 100
      threshold_type             = "PERCENTAGE"
      notification_type          = "FORECASTED"
      subscriber_email_addresses = var.emails_notificacao
    }
  }
}