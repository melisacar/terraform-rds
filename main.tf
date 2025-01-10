# Identify AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Security Group 
resource "aws_security_group" "rds_sg" {
  name        = "rds-postgres-sg"
  description = "Allow all IPs for PostgreSQL access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # All IPs 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Automatically Fetch Subnets for the Specified VPC
data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id] # VPC ID
  }
}

# Create a DB Subnet Group with the Automatically Fetched Subnets
resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "rds-subnet-group"
  description = "Subnet group for RDS"
  subnet_ids  = data.aws_subnets.selected.ids # Use dynamic subnet IDs

  tags = {
    Name = "RDS-Subnet-Group"
  }
}

# RDS Module
module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.9.0"

  engine            = "postgres"
  engine_version    = "16.3"
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage

  identifier = var.identifier
  username    = var.db_username
  password    = var.db_password

  family = var.family

  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name # Use the dynamically created subnet group

  tags = {
    Name = "RDS-Postgres-Test"
  }
}