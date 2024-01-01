output "nlb_id" {
  description = "ID of the created Network Load Balancer"
  value       = aws_lb.this.id
}

output "nlb_dns_name" {
  description = "DNS name of the Network Load Balancer"
  value       = aws_lb.this.dns_name
}

output "nlb_arn" {
  description = "ARN of the Network Load Balancer"
  value       = aws_lb.this.arn
}
