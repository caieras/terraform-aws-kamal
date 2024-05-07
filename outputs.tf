output "app_instance_id" {
  description = "ID of the Application EC2 instance."
  value = aws_instance.web_instance.id
}

output "app_instance_public_ip" {
  description = "Public IP address of the Application EC2 instance."
  value = aws_instance.web_instance.public_ip
}
