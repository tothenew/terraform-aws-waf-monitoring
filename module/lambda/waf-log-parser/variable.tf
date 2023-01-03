variable "app_name" {
  type        = string
  description = "Role middle prefix name"
  default     = "waf-log-parser"
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
  description = "Description of the lambda"
  default     = "Lambda for WAF Log service"
}

variable "role_arn" {
  type        = string
  description = "String value having Role who will be accessing the SQS"
}

variable "sqs_url" {
  type        = string
  description = "String value having SQS URL"
}

variable "bucket_name" {
  type        = string
  description = "S3 Bucket name having WAF logs stored"
}

variable "web_acl_name" {
  type        = string
  description = "WEB ACL name having WAF logs"
}
