# modules/aws/networking/variables.tf

variable "ambiente" { type = string }
variable "vpc_cidr" { type = string }

variable "subnets_publicas" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}


variable "subnets_privadas" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

# Nova variável para tags customizadas
variable "tags" {
  type    = map(string)
  default = {}
}