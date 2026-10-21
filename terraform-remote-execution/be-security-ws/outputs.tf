
output "backend_public_sg01_id" {
  description = "Security group ID for public instance 01"
  value       = aws_security_group.be_public_sg01.id
}

output "backend_private_sg01_id" {
  description = "Security group ID for private instance 01"
  value       = aws_security_group.be_private_sg01.id
}

output "backend_private_sg02_id" {
  description = "Security group ID for private instance 02"
  value       = aws_security_group.be_private_sg02.id
}

output "backend_private_sg03_id" {
  description = "Security group ID for private instance 03"
  value       = aws_security_group.be_private_sg03.id
}


