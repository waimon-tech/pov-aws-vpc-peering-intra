# Frontend VPC ID
output "frontend_vpc_id" {
  description = "VPC ID for frontend"
  value       = aws_vpc.frontend_vpc.id
}

# Frontend Subnets ID 
output "frontend_public_subnet01_id" {
  description = "subnets ID for frontend"
  value = aws_subnet.frontend_public_subnet01.id
}

output "frontend_private_subnet01_id" {
  description = "private subnets 01 ID for frontend"
  value = aws_subnet.frontend_private_subnet01.id
}

output "frontend_private_subnet02_id" {
    description = "private subnets 02 ID for frontend"
  value = aws_subnet.frontend_private_subnet02.id
}

output "frontend_private_subnet03_id" {
  value = aws_subnet.frontend_private_subnet03.id
}

# Frontend Private Subnet CIDR Blocks
output "frontend_private_subnet_cidr_02" {
  description = "Frontend private subnet 02 CIDR"
  value       = aws_subnet.frontend_private_subnet02.cidr_block
}

output "frontend_private_subnet_cidr_03" {
  description = "Frontend private subnet 03 CIDR"
  value       = aws_subnet.frontend_private_subnet03.cidr_block
}

# Frontend Private Route Table IDs
output "frontend_private_routetable_02_id" {
  description = "Frontend private route table 02 ID"
  value       = aws_route_table.frontend_private_rtb02.id
}

output "frontend_private_routetable_03_id" {
  description = "Frontend private route table 03 ID"
  value       = aws_route_table.frontend_private_rtb03.id
}