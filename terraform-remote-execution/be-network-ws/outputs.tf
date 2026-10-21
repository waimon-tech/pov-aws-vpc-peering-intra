# Backend VPC ID
output "backend_vpc_id" {
  description = "VPC ID for backend"
  value       = aws_vpc.backend_vpc.id
}

# Frontend Subnets ID 
output "backend_public_subnet01_id" {
  value = aws_subnet.backend_public_subnet01.id
}

output "backend_private_subnet01_id" {
  value = aws_subnet.backend_private_subnet01.id
}

output "backend_private_subnet02_id" {
  value = aws_subnet.backend_private_subnet02.id
}

output "backend_private_subnet03_id" {
  value = aws_subnet.backend_private_subnet03.id
}


# Backend private subnet CIDR blocks
output "backend_private_subnet_cidr_02" {
  description = "Backend private subnet 02 CIDR"
  value       = aws_subnet.backend_private_subnet02.cidr_block
}

output "backend_private_subnet_cidr_03" {
  description = "Backend private subnet 03 CIDR"
  value       = aws_subnet.backend_private_subnet03.cidr_block
}

# Backend private route table IDs
output "backend_private_routetable_02_id" {
  description = "Backend private route table 02 ID"
  value       = aws_route_table.backend_private_rtb02.id
}

output "backend_private_routetable_03_id" {
  description = "Backend private route table 03 ID"
  value       = aws_route_table.backend_private_rtb03.id
}