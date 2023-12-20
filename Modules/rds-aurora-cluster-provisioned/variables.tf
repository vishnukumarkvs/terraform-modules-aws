variable "create_db_subnet_group" {
  description = "Whether to create a DB subnet group"
  default     = false
}

variable "db_subnet_group_name" {
  description = "Name for the DB subnet group"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
  default     = []
}

variable "create_rds_cluster_parameter_group" {
  description = "Whether to create a DB parameter group"
  default     = false
}

variable "rds_cluster_parameter_group_name" {
  description = "Name for the DB parameter group"
}

variable "family" {
  description = "Family for the DB parameter group"
  default     = "postgres"
}

variable "parameter_group_settings" {
  description = "Map of DB parameter group settings"
  type        = map(string)
  default     = {}
}

variable "cluster_identifier" {
  description = "Identifier for the DB cluster"
}

variable "engine" {
  description = "Database engine (e.g., aurora)"
}

variable "engine_version" {
  description = "Database engine version. ex: 5.7.mysql_aurora.2.03.2"
}

variable "database_name" {
  description = "Name of the database"
}

variable "master_username" {
  description = "Master username for the DB cluster"
}

variable "instance_count" {
  description = "Number of writer instances for the DB cluster"
  type        = number
  default     = 1
}

variable "instance_class" {
  description = "Instance class for the writer instances"
}

variable "allocated_storage" {
  description = "Allocated storage for the writer instances (in GB)"
  type        = number
}

variable "security_group_ids" {
  description = "List of security group IDs for the DB cluster"
  type        = list(string)
#   default     = []
}

variable "is_skip_final_snapshot" {
  description = "Whether to skip the final DB snapshot during deletion"
  default     = true
}

variable "db_secret_name" {
  description = "Name for the DB secret in AWS Secrets Manager"
}

variable "recovery_window_in_days" {
  description = "Recovery window in days for the DB secret"
  type        = number
  default     = 7
}

variable "default_tags" {
  description = "A map of default tags to apply to resources"
  type        = map(string)
  default     = {}
}