########################################
# Create Security Group
########################################
resource "aws_security_group" "security_group" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  tags = {
    Name = "${var.environment_name} ${var.name}"
  }
}
