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

<!-- END_TF_DOCS -->

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-template/blob/main/LICENSE) for full details.
