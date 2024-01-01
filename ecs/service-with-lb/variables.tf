variable "lb_tg_name" {}
variable "container_port" {}
variable "lb_protocol" {}
variable "tg_deeregistration_delay" {}
variable "tg_target_type" {}
variable "vpc_id" {}
variable "lb_tg_healthy_threshold" {}
variable "default_tags" {
  type    = map(string)
  default = {}
}

variable "lb_arn" {}
variable "lb_default_action_type" {}

variable "log_group_name" {}
variable "log_retention_period" {}

variable "td_family" {}
variable "cpu" {}
variable "memory" {}
variable "execution_role_arn" {}
variable "task_role_arn" {}
variable "conatiner_port" {}
variable "container_definitions" {
  description = "A JSON-encoded list of container definitions."
  type        = string
}

variable "service_name" {}
variable "cluster_id" {}
variable "cluster_name" {}
variable "desired_count" {}
variable "deployment_maximum_percent" {}
variable "deployment_minimum_healthy_percent" {}
variable "health_check_grace_period_seconds" {}
variable "security_groups" {}
variable "subnets" {}
variable "is_assign_public_ip" {}
variable "container_name" {}
variable "min_capacity" {}
variable "max_capacity" {}
variable "autoscale_role_arn" {}
variable "autoscaling_cpu_policy_name" {}
variable "autoscaling_mem_policy_name" {}
