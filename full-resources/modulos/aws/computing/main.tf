# modules/aws/computing/main.tf

# 1. Criação de Múltiplas Instâncias EC2
resource "aws_instance" "vm" {
  for_each = var.maquinas

  ami           = each.value.ami_id
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id

  tags = merge(
    { Name = "ec2-${each.value.nome_vm}-${var.ambiente}-sp" },
    var.tags
  )
}

# 2. Criação de Múltiplos Volumes de Disco Extra
resource "aws_ebs_volume" "disco_extra" {
  for_each = var.maquinas

  # Vincula a AZ dinamicamente olhando para a respectiva EC2 criada acima
  availability_zone = aws_instance.vm[each.key].availability_zone
  size              = each.value.tamanho_disco_extra
  type              = "gp3"

  tags = merge(
    { Name = "disk-${each.value.nome_vm}-${var.ambiente}-sp" },
    var.tags
  )
}

# 3. Vinculação Dinâmica (Cada máquina ganha o seu respectivo disco)
resource "aws_volume_attachment" "ebs_att" {
  for_each = var.maquinas

  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.disco_extra[each.key].id
  instance_id = aws_instance.vm[each.key].id
}