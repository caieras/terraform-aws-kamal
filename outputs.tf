## Network Output

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

## Instance Output

output "app_instance_id" {
  description = "ID of the Application EC2 instance."
  value = aws_instance.web.id
}

output "app_instance_public_ip" {
  description = "Public IP address of the Application EC2 instance."
  value = aws_instance.web.public_ip
}
