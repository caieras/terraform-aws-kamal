output "instance_id" {
  description = "ID of the Application EC2 instance."
  value = aws_instance.app_instance.id
}

output "instance_public_ip" {
  description = "Public IP address of the Application EC2 instance."
  value = aws_instance.app_instance.public_ip
}

output "instance_id" {
  description = "ID of the Accessories EC2 instance."
  value = aws_instance.accessories_instance.id
}

output "instance_public_ip" {
  description = "Public IP address of the Accessories EC2 instance."
  value = aws_instance.accessories_instance.public_ip
}