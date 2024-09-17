########################################
# Create EIP for NAT Gateway
########################################
resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
}

########################################
# Create NAT Gateway
########################################
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = var.subnet_id
  tags = {
    Name = "${var.environment_name} ${var.name}"
  }
}
