output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.nti.id
}

output "igw_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.igw.id
}
