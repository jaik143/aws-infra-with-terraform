variable "vpc_id" {
  type = string
}

variable "rt_name" {
  type = string
}

variable "igw_id" {
  type = string
  default = ""
}

variable "nat_id" {
  type = string
  default = ""
}

variable "enable_public_route" {
  type    = bool
  default = false
}

variable "enable_private_route" {
  type    = bool
  default = false
}
