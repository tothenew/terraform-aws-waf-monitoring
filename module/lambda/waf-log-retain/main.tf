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
    runtime          = "python3.8"
    timeout          = 120
    memory_size      = 256
    description      = "Read the S3 bucket logs file of WAFv2 and send to SQS"
    vpc_config {
        subnet_ids         = var.subnet_ids
        security_group_ids = var.security_group_ids
    }
    layers = var.layer_arn
    environment {
        variables = {
            ELASTIC_HOST = var.elastic_host
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

resource "aws_lambda_permission" "lambda_permission" {
    statement_id  = "AllowExecutionFromSQS"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.lambda_function_service.function_name
    principal     = "sqs.amazonaws.com"
    source_arn    = var.sqs_arn
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
    event_source_arn = var.sqs_arn
    function_name    = aws_lambda_function.lambda_function_service.function_name
    batch_size       = 10
}
