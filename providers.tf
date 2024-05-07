terraform {
  required_providers {
    hcloud = {
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
