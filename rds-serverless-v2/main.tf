resource "aws_db_subnet_group" "this" {
  count = var.create_db_subnet_group ? 1 : 0
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = merge(var.default_tags)

}

resource "aws_rds_cluster_parameter_group" "this" {
  count = var.create_rds_cluster_parameter_group ? 1 : 0
  name        = var.rds_cluster_parameter_group_name
  family      = var.family

  dynamic "parameter" {
    for_each = var.parameters

    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}



resource "aws_rds_cluster" "this" {
  cluster_identifier        = var.cluster_identifier
  engine                    = var.engine
  engine_mode               = "provisioned"
  engine_version            = var.engine_version
  database_name             = var.database_name
  master_username           = var.master_username
  master_password           = jsondecode(aws_secretsmanager_secret_version.this.secret_string)["password"]
  db_subnet_group_name      = var.db_subnet_group_name  
  vpc_security_group_ids    = var.security_group_ids
  db_cluster_parameter_group_name = var.rds_cluster_parameter_group_name

  skip_final_snapshot    = true

    serverlessv2_scaling_configuration {
    max_capacity = var.max_capacity
    min_capacity = var.min_capacity
  }
}

resource "aws_rds_cluster_instance" "this" {
  cluster_identifier = aws_rds_cluster.this.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.this.engine
  engine_version     = aws_rds_cluster.this.engine_version
}



# password
resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "this" {
  name = var.db_secret_name
  recovery_window_in_days = var.recovery_window_in_days
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.this.result
  })
}