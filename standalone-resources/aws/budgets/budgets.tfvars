budgets = {
    "custo-mensal" = {
        budget_type  = "COST"
        limit_amount = "100"
        limit_unit   = "USD"
        time_unit    = "MONTHLY"
    
        # Filtros opcionais
        servicos_filtrados = ["AmazonEC2", "AmazonS3"] # Exemplo: Filtra apenas os custos desses serviços
        tag_chave          = "Projeto"
        tag_valor          = "Gerenciador"
    
        # Thresholds de notificação personalizados (opcional)
        notification_threshold           = 80  # Alerta se atingir 80% do limite real
        forecasted_notification_threshold = 100 # Alerta se a previsão atingir 100% do limite
    },
    "ri-utilizacao" = {
        budget_type  = "RI_UTILIZATION"
        limit_amount = "100"
        limit_unit   = "PERCENTAGE"
        time_unit    = "MONTHLY"
    
        # Sem filtros, aplica a toda a conta
    
        # Threshold de notificação personalizado (opcional)
        notification_threshold = 80 # Alerta se a utilização atingir 80%
        servicos_filtrados = ["Amazon Relational Database Service"]
    }
    "rds-savings-plans" = {
        budget_type  = "SAVINGS_PLANS_UTILIZATION"
        limit_amount = "100"
        limit_unit   = "PERCENTAGE"
        time_unit    = "MONTHLY"
    
    
        # Threshold de notificação personalizado (opcional)
        notification_threshold = 75 # Alerta se a utilização atingir 75%
        
    }
}

ambiente = "dev"
emails_notificacao = [""]