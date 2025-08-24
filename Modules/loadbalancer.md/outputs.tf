output "load_balancer_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.load_balancer.arn
}

output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.load_balancer.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}
