# VPC
resource "aws_vpc" "main" {
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
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_name
  }  
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = false

  tags = {
    Name = var.private_subnet_name
  }  
}

# Internet Gateway
resource "aws_internet_gateway" "main_gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gateway.id
  }

  tags = {
    Name = var.route_table_name
  }
}

# Associate the RT with Public Subnet
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id   = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Public Security Group 
resource "aws_security_group" "public_sg" {
  name_prefix = "web-sg"
  vpc_id = aws_vpc.main.id
  # Inbound Rules

  # SSH access from anywhere
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere
  }

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

  # Outbound Rules

  # Internet access to anywhere
  egress {
    from_port = 0
    to_port = 0
    protocol = -1  # semantically equivalent to all port
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Private Security Group
resource "aws_security_group" "private_sg" {
  name_prefix = "accessories-sg"
  vpc_id = aws_vpc.main.id
  # Inbound Rules

  # SSH access from anywhere
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = [aws_security_group.public_sg.id] # Allow all from Application server
  }

  # Outbound Rules
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Application EC2 instance in Public Subnet
resource "aws_instance" "web_instance" {
  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  # key_name = aws_key_pair.main.key_name

  tags = {
    Name = "web_instance"
  }

  user_data = data.cloudinit_config.cloud_config_web.rendered
}

# Accessories EC2 instance in Public Subnet
resource "aws_instance" "accessories_instance" {
  ami = var.ec2_ami
  instance_type = var.ec2_instance_type
  subnet_id = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  associate_public_ip_address = false
  # key_name = aws_key_pair.main.key_name

  tags = {
    Name = "accessories-instance"
  }

  user_data = data.cloudinit_config.cloud_config_web.rendered
}