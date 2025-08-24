variable "eip_name" {
  description = "Tag name for the Elastic IP"
  type        = string
}

variable "nat_name" {
  description = "Tag name for the NAT Gateway"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the NAT Gateway (must be public subnet)"
  type        = string
}
