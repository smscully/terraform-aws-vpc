########################################
# Create Security Group Rule
########################################
resource "aws_vpc_security_group_ingress_rule" "security_group_ingress_rule" {
  count                        = var.ingress == true ? 1 : 0
  security_group_id            = var.security_group_id
  cidr_ipv4                    = var.cidr_ipv4
  referenced_security_group_id = var.referenced_security_group_id
  from_port                    = var.from_port
  to_port                      = var.to_port
  ip_protocol                  = var.ip_protocol
}

resource "aws_vpc_security_group_egress_rule" "security_group_egress_rule" {
  count                        = var.egress == true ? 1 : 0
  security_group_id            = var.security_group_id
  cidr_ipv4                    = var.cidr_ipv4
  referenced_security_group_id = var.referenced_security_group_id
  from_port                    = var.from_port
  to_port                      = var.to_port
  ip_protocol                  = var.ip_protocol
}
