resource "aws_security_group" "dev_sg" {

  name = "${var.environment}-security-group"

  description = "Intentional governance violation"

  ingress {

    description = "Public SSH Access"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
  }
}
