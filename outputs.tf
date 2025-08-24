output "External_LB_DNS" {
  value = module.load_balancer_external.load_balancer_dns
}
output "internal_lb_dns" {
  description = "DNS name of the internal load balancer"
  value       = module.load_balancer_internal.load_balancer_dns
}
