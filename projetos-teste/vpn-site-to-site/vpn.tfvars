aws_vpc_cidr_block = "10.0.0.0/16"
aws_vpc_enable_dns_hostnames = true
aws_vpc_enable_dns_support = true
aws_subnet_public_cidr_block = "10.0.1.0/24"
aws_subnet_private_cidr_block = "10.0.2.0/24"
aws_subnet_public_availability_zone = "sa-east-1a"
aws_subnet_private_availability_zone = "sa-east-1b"
customer_gateway_bgp_asn = 65000
customer_gateway_ip = "179.87.174.157"
aws_vpn_destination_cidr_blocks = "192.168.15.0/24"
aws_route_table_public_cidr_block = "0.0.0.0/0"
vpn_connection_type = "ipsec.1"

instance_type = "t3.micro"
ami_id = "ami-01c4e7f7d9a667a59"
ambiente = "dev"
nome_vm = "app"
