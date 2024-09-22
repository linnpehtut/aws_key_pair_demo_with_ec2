#####Common Resource#####
resource "random_string" "suffix" {
  length  = 8
  special = false
}

locals {
  deployment_id = lower("${var.deployment_name}-${random_string.suffix.result}")
}

#####SSH Key#####
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4098
}
#since this is a private key, try to use local_sensitive_file instead of local_file
resource "local_sensitive_file" "private_key" {
  filename        = "${path.root}/generated/${local.deployment_id}-key.pem"
  content         = tls_private_key.ssh.private_key_openssh
  file_permission = "0400"
}

##### AWS Resource / aws_key_pair #####
resource "aws_key_pair" "demo_keypair" {
  count = var.create_ec2_ssh_keypair ? 1 : 0

  key_name   = "${local.deployment_id}-key"
  public_key = tls_private_key.ssh.public_key_openssh

  tags = merge(
    { Name = var.ec2_ssh_keypair_name },
    var.common_tags
  )
}