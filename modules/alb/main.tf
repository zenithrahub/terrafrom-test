resource "aws_lb" "production_alb" {

  name               = "${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    var.security_group_id
  ]

  subnets = [
    "subnet-12345678",
    "subnet-87654321"
  ]

  enable_deletion_protection = false

  tags = {
    Environment = var.environment
  }
}
