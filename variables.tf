variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
  default = "rds-postgres-test"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  sensitive   = true
}

variable "aws_region" {
  description = "AWS Region"
  default     = "eu-north-1"
}

variable "vpc_id" {
  description = "VPC ID where RDS will be deployed"
}

variable "db_username" {
  description = "Database username"
  default     = "postgres_admin"
}

variable "db_password" {
  description = "Database password"
  default     = "password123" 
}

variable "db_instance_class" {
  description = "Instance class for the RDS"
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Allocated storage size in GB"
  default     = 20
}

variable "family" {
  description = "The DB parameter group family"
  default     = "postgres16" # PostgreSQL 16.3
}