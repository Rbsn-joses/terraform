variable "dashboards" {
  type = map(object({
    dashboard_name = string
    dashboard_body = any
  }))
}