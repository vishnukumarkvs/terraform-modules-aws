resource "aws_sqs_queue" "terraform_queue_deadletter" {
  count = var.create_deadletter_queue ? 1 : 0
  name  = "${var.queue_name}-deadletter"
  message_retention_seconds = var.message_retention_seconds

  # redrive_allow_policy (optional) 
  # Main usecase = allows which queue can use this deadletter queue
  # Removing it as there is a cycle dependency
}

resource "aws_sqs_queue" "terraform_queue" {
  name = var.queue_type == "fifo" || var.queue_type == "high_throughput_fifo" ? "${var.queue_name}.fifo" : var.queue_name
  fifo_queue = var.queue_type == "fifo" || var.queue_type == "high_throughput_fifo"
  content_based_deduplication = var.queue_type == "fifo"
  deduplication_scope = var.queue_type == "high_throughput_fifo" ? "messageGroup" : null
  fifo_throughput_limit = var.queue_type == "high_throughput_fifo" ? "perMessageGroupId" : null

  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds

  redrive_policy = var.create_deadletter_queue ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter[0].arn
    maxReceiveCount     = var.max_receive_count
  }) : null

  tags = var.default_tags
}
