dashboards = {
  "example-dashboard" = {
    dashboard_name = "example-dashboard"
    dashboard_body = {
      widgets = [
        {
          type = "metric",
          x    = 0,
          y    = 0,
          width  = 6,
          height = 6,
          properties = {
            metrics = [
              ["AWS/EC2", "CPUUtilization"]
            ],
            view    = "timeSeries",
            stacked  = false,
            region   = "sa-east-1",
            title    = "EC2 CPU Utilization"
          }
        }
      ]
    }
  }
}