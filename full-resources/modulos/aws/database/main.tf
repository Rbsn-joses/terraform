resource "aws_db_subnet_group" "database" {
  for_each   = var.databases
  name       = "subnet-group-${each.key}-${var.ambiente}"
  subnet_ids = each.value.db_subnet_group_name

  tags = merge(
    { Name = "db-subnet-group-${each.key}-${var.ambiente}" },
    var.tags
  )
}

resource "aws_db_instance" "database" {
  for_each = var.databases
  engine                  = each.value.engine
  engine_version = each.value.engine_version
  instance_class = each.value.instance_class
  db_name                  = each.value.database_name
  identifier                  = "${each.key}-${var.ambiente}-db"
  username         = each.value.username
  password         = each.value.password
  allocated_storage = each.value.allocated_storage
  skip_final_snapshot = each.value.skip_final_snapshot
  final_snapshot_identifier = each.value.skip_final_snapshot ? null : each.value.final_snapshot_identifier
  backup_retention_period = each.value.backup_retention_period
  
  db_subnet_group_name = aws_db_subnet_group.database[each.key].name


    tags = merge(
    { Name = "db-${each.value.database_name}-${var.ambiente}-sp" },
    var.tags
  )
}