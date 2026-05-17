output "emails_notificacao" {
  value       = { for k, budget in aws_budgets_budget.gerenciador : k => budget.notification[*].subscriber_email_addresses }
  description = "Lista de e-mails que receberão notificações dos budgets"
}
output "budget_names" {
  value       = { for k, budget in aws_budgets_budget.gerenciador : k => budget.name }
  description = "Nomes dos budgets criados"
}
output "budget_types" {
  value       = { for k, budget in aws_budgets_budget.gerenciador : k => budget.budget_type }
  description = "Tipos dos budgets criados (COST, RI_UTILIZATION, SAVINGS_PLANS_UTILIZATION)"
}
output "budget_limits" {
  value       = { for k, budget in aws_budgets_budget.gerenciador : k => "${budget.limit_amount} ${budget.limit_unit}" }
  description = "Limites dos budgets criados (ex: '100 USD' ou '80 PERCENTAGE')"
}
output "thresholds_notificacao" {
  value       = { for k, budget in aws_budgets_budget.gerenciador : k => [for n in budget.notification : "${n.threshold} ${n.threshold_type} (${n.notification_type})"] }
  description = "Thresholds de notificação dos budgets criados (ex: '80 PERCENTAGE (ACTUAL)')"
}
output "forecasted_thresholds_notificacao" {
  value       = { for k, budget in aws_budgets_budget.gerenciador : k => [for n in budget.notification : n.notification_type == "FORECASTED" ? "${n.threshold} ${n.threshold_type} (${n.notification_type})" : null] }
  description = "Thresholds de notificação de previsão dos budgets de custo criados (ex: '100 PERCENTAGE (FORECASTED)')"
  
}