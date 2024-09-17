output "subnet_id" {
  description = "ID of the Subnet"
  value       = aws_subnet.subnet.id
}

output "subnet_cidr_block" {
  description = "CIDR block of the Subnet"
  value       = aws_subnet.subnet.cidr_block
}
