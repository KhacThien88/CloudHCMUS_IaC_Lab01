resource "aws_route_table_association" "public_a" {
  subnet_id      = var.subnet_id
  route_table_id = var.route_table_id
}
