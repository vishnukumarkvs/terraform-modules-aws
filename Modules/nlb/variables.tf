variable "name" {
  description = "Name for the Network Load Balancer"
}

variable "is_internal" {
  description = "Boolean flag to indicate if the load balancer is internal or external"
  type        = bool
}

variable "lb_type" {
  description = "Type of load balancer (e.g., 'application', 'network')"
}

variable "subnet_ids" {
  description = "List of subnet IDs where the load balancer should be deployed"
  type        = list(string)
}

variable "is_enable_cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing"
  type        = bool
}

variable "is_deletion_protected" {
  description = "Enable deletion protection for the load balancer"
  type        = bool
}

variable "enable_access_logs" {
  description = "Enable access logs for the load balancer"
  type        = bool
}

variable "auto_create_s3_log_bucket" {
  description = "Automatically create an S3 bucket for access logs"
  type        = bool
  default     = true
}

variable "nlb_access_log_bucket_name" {
  description = "Name of the S3 bucket for access logs"
  default = ""
}

variable "default_tags" {
  description = "Default tags to be applied to the load balancer"
  type        = map(string)
  default     = {}
}
