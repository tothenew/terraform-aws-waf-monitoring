variable "app_name" {
  type        = string
  description = "Role middle prefix name"
  default     = "waf-log-service"
}

variable "project_name_prefix" {
  type        = string
  description = "A string value to describe prefix of all the resources"
  default     = "tothenew"
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    Project = "ToTheNew"
  }
}

variable "role_arn" {
  type        = string
  description = "String value having Role who will be accessing the SQS"
}