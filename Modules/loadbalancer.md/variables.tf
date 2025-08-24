variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "internal_lb" {
  description = "Set to true for internal load balancer"
  type        = bool
  default     = false
}

variable "lb_security_group" {
  description = "List of security group IDs to associate with the load balancer"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for the load balancer"
  type        = list(string)
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}
