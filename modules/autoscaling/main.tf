resource "aws_autoscaling_group" "production_asg" {

  name = "${var.environment}-asg"

  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  health_check_type = "EC2"

  availability_zones = [
    "ap-south-1a"
  ]
}
