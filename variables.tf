variable "ec2_name" {
  description = "Value of the Name tag for the EC2 instance."
  type = string
  default = "ApplicationEC2"
}

# Ubuntu Server 22.04 LTS (HVM)
variable "ec2_ami" {
  description = "Value of the AMI ID for the EC2 instance."
  type = string
  default = "ami-0cdc2f24b2f67ea17"
}

variable "ec2_instance_type" {
  description = "AWS EC2 instance type."
  type = string
  default = "t2.micro"
}

variable "region" {
  description = "Value of the Region of resource"
  type = string
  default = "us-east-1"
}

variable "igw_name" {
  description = "Value of the Internet Gateway for the VPC."
  type = string
  default = "ApplicationIGW"
}

variable "public_subnet_name" {
  description = "Value of the subnet name for the VPC."
  type = string
  default = "PublicSubnet"
}

variable "private_subnet_name" {
  description = "Value of the subnet name for the VPC."
  type = string
  default = "PrivateSubnet"
}

variable "public_subnet_cidr" {
  description = "Value of the public subnet cidr for the VPC."
  type = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Value of the private subnet cidr for the VPC."
  type = string
  default = "10.0.2.0/24"
}

variable "vpc_name" {
  description = "Value of the VPC name."
  type = string
  default = "ApplicationVPC"
}

variable "vpc_cidr" {
  description = "Value of the CIDR range for the VPC."
  type = string
  default = "10.0.0.0/16"
}

# variable "key_name" {
#   description = "Name of the SSH key pair"
#   type = string
# }

# variable "public_key_path" {
#   description = "Path to the public key file"
#   type = string
# }

variable "route_table_name" {
  description = "Route Table name"
  type = string
  default = "rt"
}