resource "aws_sqs_queue" "sqs_queue" {
  name                              = "${var.project_name_prefix}-${var.app_name}-sqs"
  fifo_queue                        = false
  content_based_deduplication       = false
  visibility_timeout_seconds        = 120
  message_retention_seconds         = 345600
  max_message_size                  = 256000
  delay_seconds                     = 0
  receive_wait_time_seconds         = 0
  kms_data_key_reuse_period_seconds = 300
  tags                              = merge(var.common_tags, { "Name" = "${var.project_name_prefix}-${var.app_name}-sqs" })
}

resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = aws_sqs_queue.sqs_queue.id
  policy    = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": {
		"AWS": "${var.role_arn}"
		},
      "Action": ["sqs:SendMessage","sqs:ReceiveMessage","sqs:DeleteMessage","sqs:GetQueueAttributes"],
      "Resource": "${aws_sqs_queue.sqs_queue.arn}"
    }
  ]
}
POLICY
}