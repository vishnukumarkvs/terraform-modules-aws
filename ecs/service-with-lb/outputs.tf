output "ecs_service_name" {
  value = aws_ecs_service.this.name
}

output "ecs_service_cluster" {
  value = aws_ecs_service.this.cluster
}

output "ecs_service_task_definition" {
  value = aws_ecs_service.this.task_definition
}

output "ecs_service_desired_count" {
  value = aws_ecs_service.this.desired_count
}

output "ecs_service_security_groups" {
  value = aws_ecs_service.this.security_groups
}

output "ecs_service_subnets" {
  value = aws_ecs_service.this.subnets
}