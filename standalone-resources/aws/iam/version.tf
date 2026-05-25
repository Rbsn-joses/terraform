# environments/aws/development/versions.tf

terraform {
  # 1. Trava a versão do binário do Terraform que o seu time deve usar
  required_version = ">= 1.5.0"

  # 2. Especifica os providers necessários e suas versões
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Aceita atualizações seguras dentro da versão 5.x
    }
  }
}

# 3. Configuração prática do Provider
provider "aws" {
  region = "sa-east-1"

  
  # Dica de ouro: adicione tags automáticas para tudo que esse ambiente criar
  default_tags {
    tags = {
      Environment = "Development"
      ManagedBy   = "Terraform"
    }
  }
}