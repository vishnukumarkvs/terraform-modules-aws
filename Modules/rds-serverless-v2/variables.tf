variable "create_db_subnet_group" {
  description = "A boolean to decide whether to create the DB subnet group or not"
  type        = bool
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the DB subnet group"
  type        = list(string)
  default     = []
}

variable "default_tags" {
  description = "A map of default tags to assign to resources"
  type        = map(string)
  default = { }
}

variable "create_rds_cluster_parameter_group" {
  description = "A boolean to decide whether to create the RDS cluster parameter group or not"
  type        = bool
}

variable "rds_cluster_parameter_group_name" {
  description = "The name of the RDS cluster parameter group"
  type        = string
}

variable "family" {
  description = "The family of the RDS cluster parameter group"
  type        = string
  default = "null"
}

variable "parameters" {
  description = "A list of parameters to apply to the RDS cluster parameter group"
  type        = list(map(string))
  default = [ {} ]
}

variable "cluster_identifier" {
  description = "The identifier for the RDS cluster"
  type        = string
}

variable "engine" {
  description = "The name of the database engine to be used for the RDS cluster"
  type        = string
}

variable "engine_version" {
  description = "The engine version of the RDS cluster"
  type        = string
}


variable "database_name" {
  description = "The name of the initial database created when the RDS cluster is created"
  type        = string
}

variable "master_username" {
  description = "The master username for the RDS cluster"
  type        = string
}

variable "security_group_ids" {
  description = "A list of security group IDs to associate with the RDS cluster"
  type        = list(string)
}

variable "max_capacity" {
  description = "The maximum capacity of the serverless DB instance"
  type        = number
}

variable "min_capacity" {
  description = "The minimum capacity of the serverless DB instance"
  type        = number
}

variable "db_secret_name" {
  description = "The name of the secret in AWS Secrets Manager"
  type        = string
}

variable "recovery_window_in_days" {
  description = "The recovery window in days for the secret in AWS Secrets Manager"
  type        = number
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}
