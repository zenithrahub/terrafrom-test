resource "aws_instance" "production_server" {

  ami           = "ami-03f4878755434977f"
  instance_type = "t3.medium"

  associate_public_ip_address = true

  monitoring = false

  vpc_security_group_ids = [
    var.security_group_id
  ]

  root_block_device {

    encrypted = false
  }

  tags = {
    Environment = var.environment
  }
}
