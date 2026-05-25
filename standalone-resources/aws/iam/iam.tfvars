# ==========================================
# 1. POLÍTICAS CUSTOMIZADAS (JSONs Puros)
# ==========================================
custom_policies = {
  s3_auditoria = {
    name        = "CustomS3AuditoriaReadOnly"
    description = "Permite apenas leitura no bucket corporativo de auditoria"
    bucket_arn  = "arn:aws:s3:::meu-bucket-auditoria-da-empresa"
    policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:ListBucket"],
      "Resource": [
        "arn:aws:s3:::meu-bucket-auditoria-da-empresa",
        "arn:aws:s3:::meu-bucket-auditoria-da-empresa/*"
      ]
    }
  ]
}
EOF
  }

  ec2_suporte = {
    name        = "CustomEC2SuporteRestrito"
    description = "Permite apenas reiniciar instâncias EC2 em caso de falha"
    bucket_arn  = "none"
    policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["ec2:StartInstances", "ec2:StopInstances", "ec2:DescribeInstances"],
      "Resource": ["*"]
    }
  ]
}
EOF
  }
}

# ==========================================
# 2. GRUPOS DO IAM (Alinhado com as chaves corretas)
# ==========================================
iam_groups = {
  admin = {
    group_name           = "grupo-administradores"
    policies_arn         = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    custom_policies_keys = [] # Admins já têm acesso total, não precisam de políticas restritas
  }
  desenvolvedores = {
    group_name           = "grupo-desenvolvedores"
    policies_arn         = [
      "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
      "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
    ]
    custom_policies_keys = ["ec2_suporte"] # Vincula a chave "ec2_suporte" mapeada acima
  }
  suporte = {
    group_name           = "grupo-suporte-ti"
    policies_arn         = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
    custom_policies_keys = ["s3_auditoria"] # Vincula a chave "s3_auditoria" mapeada acima
  }
}

# ==========================================
# 3. USUÁRIOS E GRUPOS
# ==========================================
iam_users = {
  "tiago.silva" = { groups = ["grupo-administradores"] }
  "maria.souza" = { groups = ["grupo-desenvolvedores", "grupo-suporte-ti"] }
  "lucas.lima"  = { groups = ["grupo-desenvolvedores"] }
  "ana.clara"   = { groups = ["grupo-suporte-ti"] }
}