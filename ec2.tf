# Test SG
resource "aws_security_group" "aquila_app_sg" {
  name = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.aquila.id

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_app"
  }
}



# Launch Instance
resource "aws_instance" "aquila_instance" {
  ami           = "ami-011996ff98de391d1" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.aquila_pub_sb.id
  key_name      = "ec"
  count = 2
  vpc_security_group_ids = [ aws_security_group.aquila_app_sg.id ]
  user_data = file("aquila.sh")
}
