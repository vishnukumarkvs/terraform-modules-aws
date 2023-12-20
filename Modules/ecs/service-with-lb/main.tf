resource "aws_lb_target_group" "this" {
  name = var.lb_tg_name
  port = var.container_port
  protocol = var.lb_protocol
  deregistration_delay = var.tg_deeregistration_delay
  target_type = var.tg_target_type
  vpc_id = var.vpc_id
  health_check {
    healthy_threshold = var.lb_tg_healthy_threshold
    unhealthy_threshold = var.lb_tg_healthy_threshold
    protocol = var.lb_protocol
  }
  tags = merge(var.default_tags,{"Name"=var.lb_tg_name})
  lifecycle {
    ignore_changes = [ health_check ]
  }
}

resource "aws_lb_listener" "thid" {
  load_balancer_arn = var.lb_arn
  port = var.container_port
  protocol = var.lb_protocol
  default_action {
    target_group_arn = aws_lb_target_group.this.id
    type = var.lb_default_action_type
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = var.log_group_name
  retention_in_days = var.log_retention_period
  tags = merge(var.default_tags,{"Name"=var.log_group_name})
}

resource "aws_ecs_task_definition" "this" {
  depends_on = [aws_cloudwatch_log_group.this,]
  family = var.td_family
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = var.cpu
  memory = var.memory
  execution_role_arn = var.execution_role_arn
  task_role_arn = var.task_role_arn
  container_definitions = var.container_definitions
  tags = var.default_tags
}

resource "aws_ecs_service" "this" {
  depends_on = [aws_lb_listener.this,]
  name = var.service_name
  cluster = var.cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count = var.desired_count
  launch_type = "FARGATE"
  deployment_maximum_percent = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  network_configuration {
    security_groups = var.security_groups
    subnets = var.subnets
    assign_public_ip = var.is_assign_public_ip
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.this.id
    container_name = var.container_name
    container_port = var.container_port
  }
  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_appautoscaling_target" "autoscale_target_01" {
  service_namespace = "ecs"
  resource_id = "service/${var.cluster_name}/${var.service_name}" # --resource-id service/$CLUSTER_NAME/$SERVICE_NAME
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity = var.min_capacity
  max_capacity = var.max_capacity
  role_arn = var.autoscale_role_arn
  lifecycle {
    ignore_changes = [role_arn]
  }
}

resource "aws_appautoscaling_policy" "autoscale_target_01_policy_cpu" {
 name = var.autoscaling_cpu_policy_name
 policy_type = "TargetTrackingScaling"
 service_namespace = aws_appautoscaling_target.autoscale_target_01.service_namespace
 scalable_dimension = aws_appautoscaling_target.autoscale_target_01.scalable_dimension
 resource_id = aws_appautoscaling_target.autoscale_target_01.resource_id
 target_tracking_scaling_policy_configuration {
     predefined_metric_specification {
     predefined_metric_type = "ECSServiceAverageCPUUtilization"
  }
   target_value = 80
    scale_in_cooldown = "60"
    scale_out_cooldown = "60"
  }
}

resource "aws_appautoscaling_policy" "autoscale_target_01_policy_mem" {
  name = var.autoscaling_mem_policy_name
  policy_type = "TargetTrackingScaling"
  service_namespace = aws_appautoscaling_target.autoscale_target_01.service_namespace
  scalable_dimension = aws_appautoscaling_target.autoscale_target_01.scalable_dimension
  resource_id = aws_appautoscaling_target.autoscale_target_01.resource_id
  target_tracking_scaling_policy_configuration {
      predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = 80
    scale_in_cooldown = "60"
    scale_out_cooldown = "60"
  }
}
