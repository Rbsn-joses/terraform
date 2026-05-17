# modulos/aws/database/variables.tf
variable ambiente { type = string }
variable databases {
    type = map(object({
    engine                  = string
    instance_class          = string
    identifier                  = string
    engine_version = string
    allocated_storage = number
    database_name           = string
    skip_final_snapshot = bool
    final_snapshot_identifier = string
    username         = string
    password         = string
    backup_retention_period = number

    db_subnet_group_name            = list(string)

}))
}
   
variable tags {
    type    = map(string)
    default = {}
}