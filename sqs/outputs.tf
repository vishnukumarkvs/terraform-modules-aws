output "queue_url" {
  description = "The URL of the SQS queue."
  value       = aws_sqs_queue.terraform_queue.id
}

output "deadletter_queue_url" {
  description = "The URL of the Dead-letter queue."
  value       = var.create_deadletter_queue ? aws_sqs_queue.terraform_queue_deadletter[0].id : ""
}
