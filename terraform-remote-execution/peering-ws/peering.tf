# VPC Peering: Frontend VPC <-> Backend VPC
resource "aws_vpc_peering_connection" "fevpc_peering_bevpc" {
  vpc_id      = data.terraform_remote_state.fe_network.outputs.frontend_vpc_id
  peer_vpc_id = data.terraform_remote_state.be_network.outputs.backend_vpc_id
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

# Frontend Private Route Table 02 -> Backend VPC
resource "aws_route" "fevpc_private_subnet02_to_bevpc_private_subnet02" {
  route_table_id = data.terraform_remote_state.fe_network.outputs.frontend_private_routetable_02_id

  destination_cidr_block = data.terraform_remote_state.be_network.outputs.backend_private_subnet_cidr_02

  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
}

# Backend Private Route Table 02 -> Frontend VPC
resource "aws_route" "bevpc_private_subnet02_to_fevpc_private_subnet02" {
  route_table_id = data.terraform_remote_state.be_network.outputs.backend_private_routetable_02_id

  destination_cidr_block = data.terraform_remote_state.fe_network.outputs.frontend_private_subnet_cidr_02

  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
}

# Frontend Private Route Table 03 -> Backend VPC
resource "aws_route" "fevpc_private_subnet03_to_bevpc_private_subnet03" {
  route_table_id = data.terraform_remote_state.fe_network.outputs.frontend_private_routetable_03_id

  destination_cidr_block = data.terraform_remote_state.be_network.outputs.backend_private_subnet_cidr_03

  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
}

# Backend Private Route Table 03 -> Frontend VPC
resource "aws_route" "bevpc_private_subnet03_to_fevpc_private_subnet03" {
  route_table_id = data.terraform_remote_state.be_network.outputs.backend_private_routetable_03_id

  destination_cidr_block = data.terraform_remote_state.fe_network.outputs.frontend_private_subnet_cidr_03

  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
}