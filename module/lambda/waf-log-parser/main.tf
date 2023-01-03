data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "archive_file" "archive_function_obj" {
  type        = "zip"
  source_dir  = "${path.module}/function"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "lambda_function_service" {
  filename         = "lambda_function.zip"
  source_code_hash = data.archive_file.archive_function_obj.output_base64sha256
  function_name    = "${var.project_name_prefix}-${var.app_name}"
  role             = var.role_arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  timeout          = 600
  memory_size      = 512
  description      = "Read the S3 bucket logs file of WAFv2 and send to SQS"
  environment {
    variables = {
      SQS_URL = var.sqs_url
    }
  }
  tags = merge(var.common_tags, tomap({ "Name" : "${var.project_name_prefix}-${var.app_name}" }))
}

resource "aws_cloudwatch_log_group" "global_cloudwatch_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_function_service.function_name}"
  retention_in_days = 7
  tags              = merge(var.common_tags, tomap({ "Name" : "${var.project_name_prefix}-${var.app_name}" }))
}

resource "aws_lambda_function_event_invoke_config" "event_invoke" {
  function_name                = aws_lambda_function.lambda_function_service.function_name
  maximum_event_age_in_seconds = 3600
  maximum_retry_attempts       = 0
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id   = "AllowExecutionFromS3Bucket"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.lambda_function_service.function_name
  principal      = "s3.amazonaws.com"
  source_arn     = "arn:aws:s3:::${var.bucket_name}"
  source_account = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.bucket_name
  lambda_function {
    id                  = "${var.project_name_prefix}-${var.app_name}"
    lambda_function_arn = aws_lambda_function.lambda_function_service.arn
    events = [
      "s3:ObjectCreated:Put",
      "s3:ObjectCreated:CompleteMultipartUpload"
    ]
    filter_prefix = "AWSLogs/${data.aws_caller_identity.current.account_id}/WAFLogs/${data.aws_region.current.name}/${var.web_acl_name}/"
    filter_suffix = ".log.gz"
  }
  depends_on = [
    aws_lambda_permission.allow_bucket
  ]
}