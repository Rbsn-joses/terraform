# Cria a Rede Principal
resource "aws_vpc" "main" {
  cidr_block           = var.aws_vpc_cidr_block
  enable_dns_hostnames = var.aws_vpc_enable_dns_hostnames
  enable_dns_support   = var.aws_vpc_enable_dns_support  

  tags = merge(
    { Name = "vpc-principal-producao" },
    var.tags
  )
}

# Cria a Subnet Pública (Acesso direto à internet se precisar)
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.aws_subnet_public_cidr_block
  availability_zone       = var.aws_subnet_public_availability_zone
  map_public_ip_on_launch = true

  tags = merge(
    { Name = "subnet-publica-1a" },
    var.tags
  )
}

# Cria a Subnet Privada (Onde seus recursos protegidos vão rodar e a VPN vai acessar)
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.aws_subnet_private_cidr_block
  availability_zone = var.aws_subnet_private_availability_zone

  tags = merge(
    { Name = "subnet-privada-protegida-1a" },
    var.tags
  )
}

# Internet Gateway para dar saída de internet para a VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    { Name = "igw-principal" },
    var.tags
  )
}

# Tabela de Rotas da Subnet Pública
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.aws_route_table_public_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    { Name = "tabela-rotas-publica" },
    var.tags
  )
}

# Associa a tabela de rotas pública à subnet pública
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# Tabela de Rotas da Subnet Privada (Aqui a VPN vai injetar os caminhos)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    { Name = "tabela-rotas-privada" },
    var.tags
  )
}

# Associa a tabela de rotas privada à subnet privada
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private_rt.id
}


# ==============================================================================
# 2. ESTRUTURA DA VPN (CONEXÃO COM A SUA CASA)
# ==============================================================================

# Cadastro do seu Roteador de Casa na AWS
resource "aws_customer_gateway" "casa" {
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_ip
  type       = var.vpn_connection_type

  tags = merge(
    { Name = "customer-gateway-casa" },
    var.tags
  )
}

# Cria o receptor de VPN na AWS e já acopla ele dentro da nossa nova VPC
resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    { Name = "vpn-gateway-principal" },
    var.tags
  )
}

# Ativa a Propagação de Rotas: Faz a tabela privada aprender sozinha o caminho para a sua casa
resource "aws_vpn_gateway_route_propagation" "private_propagation" {
  vpn_gateway_id = aws_vpn_gateway.vpn_gw.id
  route_table_id = aws_route_table.private_rt.id
}

# Cria o link final da VPN estabelecendo os parâmetros e os 2 túneis
resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = aws_vpn_gateway.vpn_gw.id
  customer_gateway_id = aws_customer_gateway.casa.id
  type                = var.vpn_connection_type
  static_routes_only  = true

  tags = merge(
    { Name = "vpn-site-to-site-casa" },
    var.tags
  )
}

# Informa à AWS qual é a faixa de IP interna que você usa na sua casa
resource "aws_vpn_connection_route" "rota_interna_casa" {
  destination_cidr_block = var.aws_vpn_destination_cidr_blocks
  vpn_connection_id      = aws_vpn_connection.main.id

}
resource "aws_instance" "vm" {

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private.id

  tags = merge(
    { Name = "ec2-${var.nome_vm}-${var.ambiente}-sp" },
    var.tags
  )
}