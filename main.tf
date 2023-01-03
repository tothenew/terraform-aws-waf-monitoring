module "role" {
  source              = "./module/role"
  common_tags         = var.common_tags
  project_name_prefix = var.project_name_prefix
  bucket_name         = var.bucket_name
  web_acl_name        = var.web_acl_name
}

module "sqs" {
  source              = "./module/sqs"
  common_tags         = var.common_tags
  project_name_prefix = var.project_name_prefix
  role_arn            = module.role.role_arn
}

module "lambda_parser" {
  source              = "./module/lambda/waf-log-parser"
  common_tags         = var.common_tags
  project_name_prefix = var.project_name_prefix
  role_arn            = module.role.role_arn
  sqs_url             = module.sqs.sqs_id
  bucket_name         = var.bucket_name
  web_acl_name        = var.web_acl_name
}

module "lambda_retain" {
  source              = "./module/lambda/waf-log-retain"
  common_tags         = var.common_tags
  project_name_prefix = var.project_name_prefix
  role_arn            = module.role.role_arn
  sqs_arn             = module.sqs.sqs_arn
  elastic_host        = var.elastic_host
  layer_arn           = [aws_lambda_layer_version.lambda_layer.arn]
  security_group_ids  = [aws_security_group.security_group.id]
  subnet_ids          = var.subnet_ids
}
