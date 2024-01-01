resource "aws_db_subnet_group" "this" {
  count = var.create_db_subnet_group ? 1 : 0
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids

  tags = merge(var.default_tags)

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


resource "aws_db_cluster" "this" {
  cluster_identifier        = var.cluster_identifier
  engine                    = var.engine
  # availability_zones        = var.availability_zones
  database_name             = var.database_name
  master_username           = var.master_username
  master_password           = jsondecode(aws_secretsmanager_secret_version.this.secret_string)["password"]
  db_subnet_group_name      = aws_db_subnet_group.this.name  
  vpc_security_group_ids    = var.security_group_ids
  db_cluster_parameter_group_name = aws_db_cluster_parameter_group.this.name

  skip_final_snapshot    = true
}

resource "aws_db_instance" "primary_instance" {
  count                  = var.writer_instance_count
  identifier             = "${var.cluster_identifier}-instance-${count.index + 1}"
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  db_subnet_group_name   = var.db_subnet_group_name
  skip_final_snapshot    = var.is_skip_final_snapshot
}  

resource "aws_db_instance" "reader_instances" {
  count                  = var.reader_instance_count
  identifier             = "${var.cluster_identifier}-instance-${count.index + 1}"
  instance_class         = var.reader_instance_class
  allocated_storage      = var.reader_allocated_storage
  engine                 = var.engine
  db_subnet_group_name   = var.db_subnet_group_name
  skip_final_snapshot    = var.is_skip_final_snapshot
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