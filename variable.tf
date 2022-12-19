variable "app_name" {
    type        = string
    description = "App middle prefix name"
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
    default     = {
        Project = "ToTheNew"
    }
}

variable "bucket_name" {
    type        = string
    description = "S3 Bucket name having WAF logs stored"
}

variable "web_acl_name" {
    type        = string
    description = "WEB ACL name having WAF logs"
}

variable "vpc_id" {
    type = string
    description = "VPC Id of the AWS account"
}

variable "subnet_ids" {
    type        = list(string)
    description = "List of subnets to attach on lambda"
}

variable "elastic_host" {
    type        = string
    description = "Elasticsearch host where logs will be send"
}