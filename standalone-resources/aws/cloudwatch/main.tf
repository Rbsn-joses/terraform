resource "aws_cloudwatch_dashboard" "main" {
  for_each = var.dashboards
  dashboard_name = each.value.dashboard_name

  dashboard_body = jsonencode(each.value.dashboard_body)
}