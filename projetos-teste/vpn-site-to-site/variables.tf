variable "customer_gateway_ip" {
  type        = string
  description = "IP público do roteador da sua casa (ex: 179.182.X.X)"
}
variable "aws_vpc_cidr_block" {
  type        = string
  description = "Faixa de IPs privados para a VPC (ex: 10.0.0.0/16)"
  
}
variable "aws_vpc_enable_dns_hostnames" {
  type        = bool
  description = "Habilitar resolução de DNS dentro da VPC (true/false)"
  
}
variable "aws_vpc_enable_dns_support" {
  type        = bool
  description = "Habilitar suporte a DNS dentro da VPC (true/false)"
  
}
variable "aws_subnet_public_cidr_block" {
  type        = string
  description = "Faixa de IPs para a Subnet Pública (ex: 10.0.1.0/24)"
  
}
variable "aws_subnet_private_cidr_block" {
  type        = string
  description = "Faixa de IPs para a Subnet Privada (ex: 10.0.2.0/24)"
  
}
variable "aws_subnet_public_availability_zone" {
  type        = string
  description = "Zona de disponibilidade para a Subnet Pública (ex: us-east-1a)"
  
}
variable "aws_subnet_private_availability_zone" {
  type        = string
  description = "Zona de disponibilidade para a Subnet Privada (ex: us-east-1a)"
  
}
variable "customer_gateway_bgp_asn" {
  type        = number
  description = "Número ASN para o roteador da sua casa (ex: 65000)"
}
variable "aws_vpn_destination_cidr_blocks" {
  type        = string
  description = "Lista de rotas estáticas para injetar na tabela de rotas privada (ex: [\"192.168.15.0/24\"])"
  
}

variable "aws_route_table_public_cidr_block" {
  type        = string
  description = "Faixa de IPs para a rota padrão da Subnet Pública (ex: 0.0.0.0/0)"
  
}
variable "vpn_connection_type" {
  type        = string
  description = "Tipo de VPN Connection (ex: ipsec.1)"
  
}

variable "tags" {
  description = "Tags comuns aplicadas a todos os recursos"
  type        = map(string)
  default     = {}
}

variable "instance_type" {
  description = "Tipo de instância EC2 para testes (ex: t3.micro)"
  type        = string
  
}
variable "ami_id" {
  description = "ID da AMI para a instância EC2 de teste (ex: ami-0c55b159cbfafe1f0)"
  type        = string
  
}
variable "ambiente" {
  description = "Ambiente para nomear os recursos (ex: dev, prod)"
  type        = string
  
}
variable "nome_vm" {
  description = "Nome base para as VMs criadas (ex: app, db)"
  type        = string
  
}