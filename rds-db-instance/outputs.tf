output "db_instance_endpoint" {
  description = "The endpoint of the DB instance"
  value       = aws_db_instance.this.endpoint
}

output "db_instance_id" {
  description = "The ID of the DB instance"
  value       = aws_db_instance.this.id
}

output "db_security_group_ids" {
  description = "The security group IDs associated with the DB instance"
  value       = aws_db_instance.this.vpc_security_group_ids
}

output "db_parameter_group_name" {
  description = "The name of the DB parameter group associated with the DB instance"
  value       = aws_db_instance.this.parameter_group_name
}

output "db_subnet_group_names" {
  description = "The names of the DB subnet groups associated with the DB instance"
  value       = [for subnet_group in aws_db_subnet_group.this : subnet_group.name]
}

output "db_secret_name" {
  description = "The name of the AWS Secrets Manager secret for the DB credentials"
  value       = aws_secretsmanager_secret.this.name
}
