resource "aws_db_instance" "rds_instance" {
  engine                 = "postgres"
  engine_version         = "16.1"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  storage_type           = "gp2"
  db_name                = "psql"
  username               = "postgres"
  password               = "mypassword"
  multi_az               = false
  publicly_accessible    = false
  port                   = 5432
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  backup_retention_period = 7
  backup_window            = "02:00-03:00"
  maintenance_window       = "Mon:03:00-Mon:04:00"
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = true
  performance_insights_enabled = false
  skip_final_snapshot          = true
  final_snapshot_identifier    = "rds-instance-final-snapshot"
  tags = {
    Name = "rds-instance"
  }
}

resource "aws_instance" "web" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.public.id]
  associate_public_ip_address = true
  tags = {
    Name = "web-instance"
  }
  user_data = data.cloudinit_config.cloud_config_web.rendered
}

resource "aws_instance" "accessories" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.private.id]
  associate_public_ip_address = false
  tags = {
    Name = "accessories-instance"
  }
  user_data = data.cloudinit_config.cloud_config_web.rendered
}