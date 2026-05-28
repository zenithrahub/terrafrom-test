resource "aws_launch_template" "production_template" {

  name_prefix = "${var.environment}-template"

  image_id = "ami-03f4878755434977f"

  instance_type = "t3.micro"
}

resource "aws_autoscaling_group" "production_asg" {

  name = "${var.environment}-asg"

  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  health_check_type = "EC2"

  availability_zones = [
    "ap-south-1a"
  ]

  launch_template {

    id = aws_launch_template.production_template.id

    version = "$Latest"
  }
}
