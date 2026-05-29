resource "aws_instance" "drift_server" {

  ami           = "ami-03f4878755434977f"
  instance_type = "t2.micro"

  associate_public_ip_address = true

  vpc_security_group_ids = [
    var.security_group_id
  ]

  tags = {
    Environment = var.environment
  }
}
