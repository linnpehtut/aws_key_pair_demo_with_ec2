output "local_deployment_id" {
  value = local.deployment_id
}

output "random_string_result" {
  value = random_string.suffix.result
}

output "keypair" {
  value = aws_key_pair.demo_keypair
}

output "vpc" {
  value = aws_vpc.test_vpc
}

output "subnet"{
  value = aws_subnet.test_subnet
}

output "route_table" {
  value = aws_route_table.test_route_table
}

output "internet_gateway" {
  value = aws_internet_gateway.test_gateway
}

output "security_group" {
  value = aws_security_group.test_sg_allowall
}

output "instance" {
  value = aws_instance.test_ubuntu_server
}

output "instance_ip" {
  value = aws_instance.test_ubuntu_server.public_ip
}