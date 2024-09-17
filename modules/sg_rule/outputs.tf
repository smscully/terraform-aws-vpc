output "security_group_ingress_rule_id" {
  description = "ID of the Security Group Ingress Rule"
  value       = aws_vpc_security_group_ingress_rule.security_group_ingress_rule[*].id
}

output "security_group_egress_rule_id" {
  description = "ID of the Security Group Egress Rule"
  value       = aws_vpc_security_group_egress_rule.security_group_egress_rule[*].id
}
