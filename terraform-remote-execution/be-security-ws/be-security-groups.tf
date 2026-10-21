# /* Using aws_vpc_security_group_egress_rule and aws_vpc_security_group_ingress_rule resources is the current best practice. 
# Avoid using the aws_security_group_rule resource and the ingress and egress arguments of the aws_security_group resource for configuring in-line rules, 
# as they struggle with managing multiple CIDR blocks, and tags and descriptions due to the historical lack of unique IDs. */


# ==============================================================================
# 1. Backend Public Security Group 01
# ==============================================================================
resource "aws_security_group" "be_public_sg01" {
  name   = "${var.backend_prefix}-public-security-group01"
  vpc_id = data.terraform_remote_state.be_network.outputs.backend_vpc_id

  tags = {
    Name = "${var.backend_prefix}-public-security-group01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "be_public_sg01_allow_ssh" {
  security_group_id = aws_security_group.be_public_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_public_sg01_allow_icmp" {
  security_group_id = aws_security_group.be_public_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8
  ip_protocol       = "icmp"
  to_port           = 0
  description       = "Allow inbound ping (ICMP Echo Request)"
}

resource "aws_vpc_security_group_ingress_rule" "be_public_sg01_allow_http" {
  security_group_id = aws_security_group.be_public_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "be_public_sg01_allow_https" {
  security_group_id = aws_security_group.be_public_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "be_public_sg01_allow_all_traffic" {
  security_group_id = aws_security_group.be_public_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# ==============================================================================
# 2. Backend Private Security Group 01
# ==============================================================================
resource "aws_security_group" "be_private_sg01" {
  name   = "${var.backend_prefix}-private-security-group01"
  vpc_id = data.terraform_remote_state.be_network.outputs.backend_vpc_id

  tags = {
    Name = "${var.backend_prefix}-private-security-group01"
  }
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg01_allow_ssh" {
  security_group_id            = aws_security_group.be_private_sg01.id
  referenced_security_group_id = aws_security_group.be_public_sg01.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg01_allow_icmp" {
  security_group_id            = aws_security_group.be_private_sg01.id
  referenced_security_group_id = aws_security_group.be_public_sg01.id
  from_port                    = 8
  ip_protocol                  = "icmp"
  to_port                      = 0
}

resource "aws_vpc_security_group_egress_rule" "be_private_sg01_allow_all_traffic" {
  security_group_id = aws_security_group.be_private_sg01.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# ==============================================================================
# 3. Backend Private Security Group 02
# ==============================================================================
resource "aws_security_group" "be_private_sg02" {
  name   = "${var.backend_prefix}-private-security-group02"
  vpc_id = data.terraform_remote_state.be_network.outputs.backend_vpc_id

  tags = {
    Name = "${var.backend_prefix}-private-security-group02"
  }
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg02_allow_ssh_from_be_private_sg01" {
  security_group_id            = aws_security_group.be_private_sg02.id
  referenced_security_group_id = aws_security_group.be_private_sg01.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg02_allow_icmp_from_be_private_sg01" {
  security_group_id            = aws_security_group.be_private_sg02.id
  referenced_security_group_id = aws_security_group.be_private_sg01.id
  from_port                    = 8
  ip_protocol                  = "icmp"
  to_port                      = 0
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg02_allow_ssh_from_fe_private_sg02" {
  security_group_id = aws_security_group.be_private_sg02.id
  #referenced_security_group_id = data.terraform_remote_state.fe_security.outputs.frontend_private_sg02_id
  cidr_ipv4   = var.frontend_private_subnet_cidr[1]
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg02_allow_icmp_from_fe_private_sg02" {
  security_group_id = aws_security_group.be_private_sg02.id
  #referenced_security_group_id = data.terraform_remote_state.fe_security.outputs.frontend_private_sg02_id
  cidr_ipv4   = var.frontend_private_subnet_cidr[1]
  from_port   = 8
  ip_protocol = "icmp"
  to_port     = 0
}

resource "aws_vpc_security_group_egress_rule" "be_private_sg02_allow_ssh_to_fe_private_sg02" {
  security_group_id = aws_security_group.be_private_sg02.id
  #referenced_security_group_id = data.terraform_remote_state.fe_security.outputs.frontend_private_sg02_id
  cidr_ipv4   = var.frontend_private_subnet_cidr[1]
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "be_private_sg02_allow_icmp_to_fe_private_sg02" {
  security_group_id = aws_security_group.be_private_sg02.id
  #referenced_security_group_id = data.terraform_remote_state.fe_security.outputs.frontend_private_sg02_id
  cidr_ipv4   = var.frontend_private_subnet_cidr[1]
  from_port   = 8
  ip_protocol = "icmp"
  to_port     = 0
}

# ==============================================================================
# 4. Backend Private Security Group 03
# ==============================================================================
resource "aws_security_group" "be_private_sg03" {
  name   = "${var.backend_prefix}-private-security-group03"
  vpc_id = data.terraform_remote_state.be_network.outputs.backend_vpc_id

  tags = {
    Name = "${var.backend_prefix}-private-security-group03"
  }
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg03_allow_ssh_from_be_private_sg01" {
  security_group_id            = aws_security_group.be_private_sg03.id
  referenced_security_group_id = aws_security_group.be_private_sg01.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg03_allow_icmp_from_be_private_sg01" {
  security_group_id            = aws_security_group.be_private_sg03.id
  referenced_security_group_id = aws_security_group.be_private_sg01.id
  from_port                    = 8
  ip_protocol                  = "icmp"
  to_port                      = 0
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg03_allow_ssh_from_fe_private_sg03" {
  security_group_id = aws_security_group.be_private_sg03.id
  #referenced_security_group_id = data.terraform_remote_state.fe_security.outputs.frontend_private_sg03_id
  cidr_ipv4   = var.frontend_private_subnet_cidr[2]
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg03_allow_icmp_from_fe_private_sg03" {
  security_group_id = aws_security_group.be_private_sg03.id
  #referenced_security_group_id = data.terraform_remote_state.fe_security.outputs.frontend_private_sg03_id
  cidr_ipv4   = var.frontend_private_subnet_cidr[2]
  from_port   = 8
  ip_protocol = "icmp"
  to_port     = 0
}

resource "aws_vpc_security_group_egress_rule" "be_private_sg03_allow_ssh_to_fe_private_sg03" {
  security_group_id = aws_security_group.be_private_sg03.id
  #referenced_security_group_id = data.terraform_remote_state.fe_security.outputs.frontend_private_sg03_id
  cidr_ipv4   = var.frontend_private_subnet_cidr[2]
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "be_private_sg03_allow_icmp_to_fe_private_sg03" {
  security_group_id = aws_security_group.be_private_sg03.id
  # referenced_security_group_id = data.terraform_remote_state.fe_security.outputs.frontend_private_sg03_id
  cidr_ipv4   = var.frontend_private_subnet_cidr[2]
  from_port   = 8
  ip_protocol = "icmp"
  to_port     = 0
}
