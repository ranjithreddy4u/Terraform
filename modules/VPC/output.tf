# Output the VPC ID
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

# Output the Public Subnet IDs
output "public_subnet_ids" {
  description = "List of Public Subnet IDs"
  value       = aws_subnet.public[*].id
}

# Output the Private Subnet IDs
output "private_subnet_ids" {
  description = "List of Private Subnet IDs"
  value       = aws_subnet.private[*].id
}

# Output the Internet Gateway ID
output "igw_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# Output the NAT Gateway IDs
output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.nat[*].id
}

# Output the Public Route Table ID
output "public_route_table_id" {
  description = "ID of the Public Route Table"
  value       = aws_route_table.public.id
}

# Output the Private Route Table IDs
output "private_route_table_id" {
  description = "ID of the Private Route Table "
  value       = aws_route_table.private[*].id
}
