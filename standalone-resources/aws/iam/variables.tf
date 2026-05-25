variable "custom_policies" {
  type = map(object({
    name        = string
    description = string
    bucket_arn  = string
    
    policy = any
  }))
}

variable "iam_groups" {
  type = map(object({
    group_name   = string
    policies_arn = list(string)
    custom_policies_keys = optional(list(string))
  }))
}

variable "iam_users" {
  type = map(object({
    groups = list(string)
  }))
}