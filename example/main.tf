module "waf_log_service" {
  source              = "git::https://github.com/tothenew/terraform-aws-waf-monitoring.git"
  project_name_prefix = "tothenew"
  bucket_name         = "aws-waf-logs-tothenew"
  elastic_host        = "10.20.10.10"
  subnet_ids          = ["sg-9999999", "sg-9999999"]
  vpc_id              = "vpc-999999999999"
  web_acl_name        = "wafv2-acl"
}