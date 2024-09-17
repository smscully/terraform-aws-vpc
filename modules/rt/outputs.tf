output "route_table_id" {
  description = "ID of the Route Table"
  value       = aws_route_table.route_table.id
}

output "route_table_association_id" {
  description = "ID of the Route Table Association"
  value       = aws_route_table_association.route_table_association.id
}
