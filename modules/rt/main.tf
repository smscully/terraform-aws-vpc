########################################
# Create Route Table
########################################
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.environment_name} ${var.name}"
  }
}

########################################
# Create Route Table Association
########################################
resource "aws_route_table_association" "route_table_association" {
  route_table_id = aws_route_table.route_table.id
  subnet_id      = var.subnet_id
}
