########################################
# Create VPC 
########################################
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = "${var.environment_name} VPC"
  }
}

########################################
# Create Internet Gateway
########################################
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment_name} Internet Gateway"
  }
}
