resource "aws_security_group" "security_group" {
  name        = "${var.project_name_prefix}-${var.app_name}-sg"
  tags        = merge(var.common_tags, tomap({ "Name" : "${var.project_name_prefix}-${var.app_name}-sg" }))
  description = "Security group will attach to lambda"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["${var.elastic_host}/32"]
    description = "Allow traffic from lambda to Elastic Host"
  }
}