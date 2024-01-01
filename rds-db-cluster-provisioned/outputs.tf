output "db_subnet_group_name" {
  description = "The name of the DB subnet group associated with the DB instance"
  value       = aws_db_subnet_group.this.name
}

output "db_cluster_id" {
  description = "The ID of the DB cluster"
  value       = aws_db_cluster.this.id
}

output "aurora_primary_instance_ids" {
  description = "List of identifiers for Aurora primary instances"
  value       = [for instance in aws_db_instance.aurora_primary_instance : instance.identifier]
}

output "aurora_reader_instance_ids" {
  description = "List of identifiers for Aurora reader instances"
  value       = [for instance in aws_db_instance.aurora_reader_instances : instance.identifier]
}

output "db_secret_arn" {
  description = "The ARN of the DB secret in AWS Secrets Manager"
  value       = aws_secretsmanager_secret.this.arn
}
