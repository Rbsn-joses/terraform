output "vpc_id" {
  description = "ID da VPC criada"
  value       = aws_vpc.main.id
}

output "subnet_public_id" {
  description = "ID da Subnet Pública criada"
  value       = aws_subnet.public.id
}

output "subnet_private_id" {
  description = "ID da Subnet Privada criada"
  value       = aws_subnet.private.id
}

output "internet_gateway_id" {
  description = "ID do Internet Gateway criado"
  value       = aws_internet_gateway.igw.id
}

output "vpn_gateway_id" {
  description = "ID do VPN Gateway criado"
  value       = aws_vpn_gateway.vpn_gw.id
}
output "ec2_instance_ids" {
  description = "IDs das instâncias EC2 criadas"
  value       = aws_instance.vm.id
  
}
output "ec2_instance_public_ips" {
  description = "IPs públicos das instâncias EC2 criadas"
  value       = aws_instance.vm.public_ip
  
}
output "ec2_private_ips" {
  description = "IPs privados das instâncias EC2 criadas"
  value       = aws_instance.vm.private_ip
  
}
