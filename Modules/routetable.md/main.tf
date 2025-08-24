resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.rt_name
  }
}

resource "aws_route" "public_route" {
  count = var.enable_public_route ? 1 : 0

  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route" "private_route" {
  count = var.enable_private_route ? 1 : 0

  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_id
}
