resource "aws_lambda_layer_version" "lambda_layer" {
    filename   = "lambda_layer_elasticsearch.zip"
    layer_name = "${var.project_name_prefix}-${var.app_name}"
    compatible_runtimes = ["python3.8"]
}