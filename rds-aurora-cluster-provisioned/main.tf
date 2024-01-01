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
    for_each = var.parameter_group_settings

    content {
      name         = parameter.value.name
      value        = parameter.value.value
    }
  }
}


resource "aws_rds_cluster" "this" {
  cluster_identifier        = var.cluster_identifier
  engine                    = var.engine
  engine_version            = var.engine_version
  database_name             = var.database_name
  master_username           = var.master_username
  master_password           = jsondecode(aws_secretsmanager_secret_version.this.secret_string)["password"]
  db_subnet_group_name      = var.db_subnet_group_name
  vpc_security_group_ids    = var.security_group_ids
  db_cluster_parameter_group_name = var.rds_cluster_parameter_group_name

  skip_final_snapshot    = true
}

# Aurora automatically handles 1 writer instance and other reader instances
resource "aws_rds_cluster_instance" "primary_instance" {
  count                  = var.instance_count
  cluster_identifier     = "${var.cluster_identifier}-instance-${count.index + 1}"
  instance_class         = var.instance_class
  engine                 = var.engine
  engine_version         = var.engine_version
  db_subnet_group_name   = var.db_subnet_group_name
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
    username = var.master_username
    password = random_password.this.result
  })
}