########################################
# Create Network ACL
########################################
resource "aws_network_acl" "network_acl" {
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.environment_name} ${var.name}"
  }
}
