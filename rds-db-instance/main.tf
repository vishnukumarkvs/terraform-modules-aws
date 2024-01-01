resource "aws_db_instance" "this" {
  identifier             = var.identifier
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  username               = var.db_username
  password               = jsondecode(aws_secretsmanager_secret_version.this.secret_string)["password"]
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.security_group_ids
  parameter_group_name   = var.db_parameter_group_name
  publicly_accessible    = var.is_publicly_accesible
  skip_final_snapshot    = var.is_skip_final_snapshot
  tags                   = merge(var.default_tags)

}

resource "aws_db_parameter_group" "this" {
  count = var.create_parameter_group ? 1 : 0

  name   = var.db_parameter_group_name
  family = var.family

  dynamic "parameter" {
    for_each = var.parameter_group_settings

    content {
      name  = parameter.key
      value = parameter.value
    }
  }
}


resource "aws_db_subnet_group" "this" {
  count = var.create_db_subnet_group ? 1 : 0
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = merge(var.default_tags)

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

