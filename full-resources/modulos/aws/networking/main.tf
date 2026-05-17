# modules/aws/networking/main.tf

# 1. VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = merge(
    { Name = "vpc-${var.ambiente}" },
    var.tags
  )
}

# 2. Internet Gateway (Necessário para a parte pública e para o NAT)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    { Name = "igw-${var.ambiente}" },
    var.tags
  )
}

# -------------------------------------------------------------
# PARTE PÚBLICA
# -------------------------------------------------------------

# 3. Subnets Públicas
resource "aws_subnet" "public" {
  for_each = var.subnets_publicas

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  
  # Garante que as VMs aqui ganhem IP público automaticamente
  map_public_ip_on_launch = true 

  tags = merge(
    { Name = "subnet-public-${var.ambiente}" },
    var.tags
  )
}
resource "aws_subnet" "database" {
  for_each          = var.subnets_privadas # Nova variável que vamos mapear
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  
  tags = merge(
    { Name = "subnet-priv-db-${each.key}-${var.ambiente}" },
    var.tags
  )
}

# 4. Tabela de Rota Pública (Aponta para o Internet Gateway)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(
    { Name = "rt-public-${var.ambiente}" },
    var.tags
  )
}

# 5. Associação da Rota Pública às Subnets Públicas
resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
  
}
