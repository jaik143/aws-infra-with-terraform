resource "aws_vpc" "nti" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC-${var.igw_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nti.id

  tags = {
    Name = var.igw_name
  }
}

