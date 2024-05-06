# https://docs.hetzner.com/cloud/general/locations#what-locations-are-there
variable "region" {
  type    = string
  default = "sa-east-1"
}

# https://docs.hetzner.com/cloud/servers/overview/#shared-vcpu
variable "server_type" {
  type    = string
  default = "t2.micro"
}

variable "operating_system" {
  type    = string
  default = "ubuntu-22.04"
}
