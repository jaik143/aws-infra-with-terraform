resource "aws_subnet" "project_subnet" {
  cidr_block              = var.cidr_subnet
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = var.map_public_ip
  availability_zone       = var.availability_zone

  tags = {
    Name = var.subnet_name
    Environment = var.environment
  }
}

resource "aws_route_table_association" "subnet_rt_association" {
  subnet_id      = aws_subnet.project_subnet.id
  route_table_id = var.route_table_id
}
