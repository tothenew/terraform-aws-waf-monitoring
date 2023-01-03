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

variable "description" {
  type        = string
  description = "Description of the role"
  default     = "Lambda Role for WAF Log service"
}

variable "bucket_name" {
  type        = string
  description = "S3 Bucket name having WAF logs stored"
}

variable "web_acl_name" {
  type        = string
  description = "WEB ACL name having WAF logs"
}
