variable "app_name" {
    type        = string
    description = "Role middle prefix name"
    default     = "waf-log-retain"
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

variable "description" {
    type        = string
    description = "Description of the lambda"
    default     = "Lambda for WAF Log service"
}

variable "role_arn" {
    type        = string
    description = "String value having Role who will be accessing the SQS"
}

variable "sqs_arn" {
    type        = string
    description = "String value having SQS ARN"
}

variable "subnet_ids" {
    type = list(string)
    description = "List of subnets to attach on lambda"
}

variable "security_group_ids" {
    type    = list(string)
    description = "List of Security group ids to attach on lambda"
}

variable "layer_arn" {
    type    = list(string)
    description = "List of Layer to attach on lambda"
}

variable "elastic_host" {
    type    = string
    description = "Elasticsearch host where logs will be send"
}