resource "aws_instance" "dev_server" {

  ami           = "ami-03f4878755434977f"
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    var.security_group_id
  ]

  associate_public_ip_address = true

  tags = {
    Name        = "${var.environment}-server"
    Environment = var.environment
  }
}
