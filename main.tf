# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = var.public_subnet_name
  }  
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = var.private_subnet_name
  }  
}

# Internet Gateway
resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = var.igw_name
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gateway.id
  }

  tags = {
    Name = var.igw_name
  }
}

# Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = var.igw_name
  }
}

# Associate the RT x Private Subnet
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id   = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Associate the RT x Private Subnet
resource "aws_route_table_association" "private_rt_assoc" {
  subnet_id   = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# Creating Security Group 
resource "aws_security_group" "main_sg" {
  name = "HTTP"
  vpc_id = aws_vpc.main_vpc.id
  # Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from anywhere
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port = 0
    to_port = 0
    protocol = -1  # semantically equivalent to all port
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance in Public Subnet
resource "aws_instance" "app_instance" {
  ami = var.ec2_ami
  instance_type = var.ec2_instance_type

  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  associate_public_ip_address = true

  tags = {
    Name = var.ec2_name
  }

    # user_data = data.cloudinit_config.cloud_config_web.rendered
}

# EC2 instance in Public Subnet
resource "aws_instance" "accessories_instance" {
  ami = var.ec2_ami
  instance_type = var.ec2_instance_type

  subnet_id = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.main_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.ec2_name}2"
  }
}