## Network Output

output "vpc_id" {
  value = aws_vpc.main.id
}

## Instance Output

output "web_instance_id" {
  description = "ID of the Application EC2 instance."
  value = aws_instance.web.id
}

output "web_instance_public_ip" {
  description = "Public IP address of the Application EC2 instance."
  value = aws_instance.web.public_ip
}

output "accessories_instance_id" {
  description = "ID of the Application EC2 instance."
  value = aws_instance.accessories.id
}

output "accessories_instance_public_ip" {
  description = "Public IP address of the Application EC2 instance."
  value = aws_instance.accessories.public_ip
}

output "db_name" {
  description = "The name of the database created in the RDS instance."
  value       = aws_db_instance.rds_instance.db_name
}

output "db_endpoint" {
  description = "The endpoint of the RDS instance."
  value       = aws_db_instance.rds_instance.endpoint
}

output "db_username" {
  description = "The master username for the RDS instance."
  value       = aws_db_instance.rds_instance.username
}