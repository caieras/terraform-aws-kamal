terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.3"
    }
  }
}

# Terraform will use the specified profile to authenticate with AWS.
provider "aws" {
  profile = "default"
  region  = "sa-east-1"
}

# resource "aws_key_pair" "main" {
#   key_name   = var.key_name
#   public_key = file(var.public_key_path)
# }