resource "aws_instance" "web_server" {
  ami           = "ami-03f4878755434977f"
  instance_type = "t3.micro"

  tags = {
    Name = "web-server"
  }
}
