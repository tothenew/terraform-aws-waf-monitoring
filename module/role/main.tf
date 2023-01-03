data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_role" "aws_role" {
  name        = "${var.project_name_prefix}-${var.app_name}-role"
  description = var.description

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge(var.common_tags, { "Name" = "${var.project_name_prefix}-${var.app_name}-role" })
}

## policy template
data "template_file" "service_policy_temp" {
  template = file("${path.module}/policy.tpl")
  vars = {
    bucket_name  = var.bucket_name
    account_id   = data.aws_caller_identity.current.account_id
    region_name  = data.aws_region.current.name
    web_acl_name = var.web_acl_name
    sqs_name     = "${var.project_name_prefix}-${var.app_name}-sqs"
  }
}

## creating policy
resource "aws_iam_policy" "service_policy" {
  name        = "${var.project_name_prefix}-${var.app_name}-policy"
  description = "A policy to access aws resources"
  policy      = data.template_file.service_policy_temp.rendered
  tags        = merge(var.common_tags, tomap({ "Name" : "${var.project_name_prefix}-${var.app_name}-policy" }))
}

## attaching policy to role
resource "aws_iam_role_policy_attachment" "service_policy_attachment" {
  role       = aws_iam_role.aws_role.name
  policy_arn = aws_iam_policy.service_policy.arn
}
resource "aws_iam_role_policy_attachment" "service_policy_attachment1" {
  role       = aws_iam_role.aws_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}