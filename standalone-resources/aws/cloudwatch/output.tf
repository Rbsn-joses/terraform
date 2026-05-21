output "dashboard_arns" {
  description = "Os ARNs de todos os CloudWatch Dashboards criados"
  value       = { for k, v in aws_cloudwatch_dashboard.main : k => v.dashboard_arn }
}
