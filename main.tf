resource "aws_instance" "web_server" {
  ami           = "ami-03f4878755434977f"
  instance_type = "t2.micro"

  tags = {
    Name        = "web-server"
    Owner       = "platform-team"
    Environment = "dev"
    CostCenter  = "cloud-operations"
  }
}
