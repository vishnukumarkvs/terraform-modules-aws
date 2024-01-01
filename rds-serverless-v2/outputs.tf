output "db_subnet_group_id" {
  value = {
    for idx, subnet_group in aws_db_subnet_group.this :
    idx => subnet_group.id
  }
  sensitive = false
}

output "rds_cluster_parameter_group_id" {
  value = {
    for idx, parameter_group in aws_rds_cluster_parameter_group.this :
    idx => parameter_group.id
  }
  sensitive = false
}


output "rds_cluster_id" {
  value     = aws_rds_cluster.this.id
  sensitive = false
}

output "rds_cluster_instance_id" {
  value     = aws_rds_cluster_instance.this.id
  sensitive = false
}

output "secret_arn" {
  value     = aws_secretsmanager_secret.this.arn
  sensitive = false
}

output "secret_version_id" {
  value     = aws_secretsmanager_secret_version.this.id
  sensitive = false
}
