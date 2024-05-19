resource "aws_instance" "dev" {
  ami                    = "ami-013e83f579886baeb"
  instance_type          = "t2.micro"
  key_name               =  "jenkin"
  user_data = file("test.sh")
  tags = {
    Name="userdata-tf"
  }
}