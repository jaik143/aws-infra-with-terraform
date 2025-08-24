variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the subnet"
  type        = string
}

variable "map_public_ip" {
  description = "Whether to assign public IP on launch"
  type        = bool
  default     = false
}

variable "availability_zone" {
  description = "Availability Zone for the subnet"
  type        = string
}

variable "subnet_name" {
  description = "Name tag for the subnet"
  type        = string
}

variable "route_table_id" {
  description = "Route Table ID to associate with the subnet"
  type        = string
}

variable "environment" {
  description = "Environment tag value (e.g., dev, prod)"
  type        = string
  default     = "dev"
}
