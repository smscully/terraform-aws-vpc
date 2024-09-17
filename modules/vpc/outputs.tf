output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.internet_gateway.id
}
