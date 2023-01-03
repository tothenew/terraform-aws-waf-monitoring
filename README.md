# terraform-aws-template

[![Lint Status](https://github.com/tothenew/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-aws-template)](https://github.com/tothenew/terraform-aws-template/blob/master/LICENSE)

The following content needed to be created and managed:
 - Introduction
     - This module will fetch the logs of the WAF from the S3 bucket and send them into the elasticsearch for kibana visualisation.

 # Usages
```
module "waf_log_service" {
    source              = "git::https://github.com/tothenew/terraform-aws-waf-monitoring.git"
    project_name_prefix = "tothenew"
    bucket_name         = "aws-waf-logs-tothenew"
    elastic_host        = "10.20.10.10"
    subnet_ids          = ["sg-9999999", "sg-9999999"]
    vpc_id              = "vpc-999999999999"
    web_acl_name        = "wafv2-acl"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.72 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.10 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.72 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_parser"></a> [lambda\_parser](#module\_lambda\_parser) | ./module/lambda/waf-log-parser | n/a |
| <a name="module_lambda_retain"></a> [lambda\_retain](#module\_lambda\_retain) | ./module/lambda/waf-log-retain | n/a |
| <a name="module_role"></a> [role](#module\_role) | ./module/role | n/a |
| <a name="module_sqs"></a> [sqs](#module\_sqs) | ./module/sqs | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lambda_layer_version.lambda_layer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) | resource |
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | App middle prefix name | `string` | `"waf-log-service"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | S3 Bucket name having WAF logs stored | `string` | n/a | yes |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A map to add common tags to all the resources | `map(string)` | <pre>{<br>  "Project": "ToTheNew"<br>}</pre> | no |
| <a name="input_elastic_host"></a> [elastic\_host](#input\_elastic\_host) | Elasticsearch host where logs will be send | `string` | n/a | yes |
| <a name="input_project_name_prefix"></a> [project\_name\_prefix](#input\_project\_name\_prefix) | A string value to describe prefix of all the resources | `string` | `"tothenew"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnets to attach on lambda | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC Id of the AWS account | `string` | n/a | yes |
| <a name="input_web_acl_name"></a> [web\_acl\_name](#input\_web\_acl\_name) | WEB ACL name having WAF logs | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-template/blob/main/LICENSE) for full details.
