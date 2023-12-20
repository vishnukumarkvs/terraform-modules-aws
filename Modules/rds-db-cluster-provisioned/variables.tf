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

variable "create_parameter_group" {
  description = "Whether to create a DB parameter group"
  default     = false
}

variable "db_parameter_group_name" {
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

# variable "availability_zones" {
#   description = "List of availability zones for the DB cluster"
#   type        = list(string)
# }

variable "database_name" {
  description = "Name of the database"
}

variable "master_username" {
  description = "Master username for the DB cluster"
}

variable "writer_instance_count" {
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

variable "reader_instance_count" {
  description = "Number of reader instances for the DB cluster"
  type        = number
  default     = 0
}

variable "reader_instance_class" {
  description = "Instance class for the reader instances"
}

variable "reader_allocated_storage" {
  description = "Allocated storage for the reader instances (in GB)"
  type        = number
  default     = 100
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

variable "db_username" {
  description = "Username for the DB"
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