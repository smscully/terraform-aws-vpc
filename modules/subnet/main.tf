########################################
# Retrieve List of AZs
########################################
data "aws_availability_zones" "available" {}

########################################
# Create Subnet
########################################
resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  availability_zone       = tolist(data.aws_availability_zones.available.names)[var.availability_zone]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = "${var.environment_name} ${var.name}"
  }
}
