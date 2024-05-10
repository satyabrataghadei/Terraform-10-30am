# create vpc

resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "cust_vpc"
  }
}
# create subnet
resource "aws_subnet" "dev" {
    vpc_id = aws_vpc.dev.id
    cidr_block = "10.0.0.0/24"
  
}

# create IG and attach to vpc

resource "aws_internet_gateway" "dev" {
  vpc_id = aws_vpc.dev.id

  tags={
    Name="cust-ig"
  }
}
# create RT and  configure IG (edit routes)
resource "aws_route_table" "dev" {
     vpc_id = aws_vpc.dev.id
     route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev.id
  }
  
}
  
# subnet association to add into RT (public)
resource "aws_route_table_association" "dev" {
  subnet_id      = aws_subnet.dev.id
  route_table_id = aws_route_table.dev.id
}

# create sg group
resource "aws_security_group" "dev" {
  name        = "allow_tls"
  vpc_id      = aws_vpc.dev.id
  tags = {
    Name = "dev_sg"
  }
 ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  
}
  resource "aws_instance" "dev" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.dev.id
    key_name = var.keyname
    vpc_security_group_ids = [aws_security_group.dev.id]
    tags = {
      Name = "today"
    }
} 





 