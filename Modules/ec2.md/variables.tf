variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Existing AWS key pair name to use"
  type        = string
  default     = "mykeypair"
}

variable "private_key" {
  description = "Local path to the private key file"
  type        = string
  default     = "./mykeypair.pem"
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}

variable "remote_exec" {
  description = "Commands to run on the EC2 instance via remote-exec"
  type        = list(string)
  default     = []
}

variable "user_data" {
  description = "User data script to bootstrap the instance"
  type        = string
  default     = ""
}

variable "enable_remote" {
  description = "Enable or disable remote-exec provisioner"
  type        = bool
  default     = false
}

variable "target_group_arn" {
  description = "ARN of the target group to attach EC2"
  type        = string
  default     = ""
}
