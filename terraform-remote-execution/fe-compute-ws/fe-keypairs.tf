locals {
  fe_private_key_filename = "${var.frontend_prefix}-ssh-key.pem"
}

resource "tls_private_key" "fe_keypair" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "fe_keypair" {
  key_name   = local.fe_private_key_filename
  public_key = tls_private_key.fe_keypair.public_key_openssh
}

resource "local_sensitive_file" "frontend" {
  content  = tls_private_key.fe_keypair.private_key_openssh
  filename = pathexpand("~/.ssh/${local.fe_private_key_filename}")
}
