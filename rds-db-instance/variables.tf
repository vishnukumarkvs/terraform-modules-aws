variable "identifier" {
  description = "A unique name for the DB instance"
}

variable "instance_class" {
  description = "The instance type for the DB instance"
}

variable "allocated_storage" {
  description = "The amount of allocated storage in gibibytes (GiB)"
}

variable "engine" {
  description = "The name of the database engine to be used for this DB instance"
}

variable "engine_version" {
  description = "The version number of the database engine to be used"
}

variable "db_username" {
  description = "The username for the database"
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the DB instance"
  type        = list(string)
}

variable "db_parameter_group_name" {
  description = "The name of the DB parameter group to associate with this DB instance"
}

variable "is_publicly_accesible" {
  description = "Whether the DB instance should be publicly accessible"
  type        = bool
  default     = false
}

variable "is_skip_final_snapshot" {
  description = "Whether to skip the final DB snapshot when destroying the DB instance"
  type        = bool
  default     = true
}

variable "default_tags" {
  description = "A map of default tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "create_parameter_group" {
  description = "Whether to create a DB parameter group"
  type        = bool
  default     = false
}

variable "family" {
  description = "The family of the DB parameter group"
  default = "null"
}

variable "parameter_group_settings" {
  description = "A map of parameter group settings"
  type        = map(string)
  default     = {}
}

variable "create_db_subnet_group" {
  description = "Whether to create a DB subnet group"
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
  default     = []
}

variable "db_secret_name" {
  description = "The name of the AWS Secrets Manager secret for the DB credentials"
}

variable "recovery_window_in_days" {
  description = "Recovery window after secret key is deleted"
  default = 7
}

