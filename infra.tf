#####AWS VPC#####
resource "aws_vpc" "test_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.deployment_name}-vpc"
  }
}
#####AWS Internet Gateway#####
resource "aws_internet_gateway" "test_gateway" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "${var.deployment_name}-gateway"
  }
}
#####AWS Subnet#####
resource "aws_subnet" "test_subnet" {
  vpc_id = aws_vpc.test_vpc.id

  cidr_block        = "10.0.0.0/24"
  availability_zone = var.aws_zone

  tags = {
    Name = "${var.deployment_name}-subnet"
  }
}
#####AWS Route Table#####
resource "aws_route_table" "test_route_table" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_gateway.id
  }

  tags = {
    Name = "${var.deployment_name}-route-table"
  }
}
#####AWS Route Table & Subnet Association#####
resource "aws_route_table_association" "test_route_table_association" {
  subnet_id      = aws_subnet.test_subnet.id
  route_table_id = aws_route_table.test_route_table.id
}

#####AWS Security Group to allow ssh traffic#####
resource "aws_security_group" "test_sg_allowall" {
  name        = "${var.deployment_name}-allowall"
  description = "Test Security Group - allow all traffic"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#####AWS EC2 Instance to test the KeyPair created earlier#####
resource "aws_instance" "test_ubuntu_server" {
  depends_on = [
    aws_route_table_association.test_route_table_association,
    aws_key_pair.demo_keypair
  ]
  ami           = data.aws_ami.ubuntu_freetier_latest.id
  instance_type = var.instance_type

  key_name                    = aws_key_pair.demo_keypair[0].key_name
  vpc_security_group_ids      = [aws_security_group.test_sg_allowall.id]
  subnet_id                   = aws_subnet.test_subnet.id
  associate_public_ip_address = true
}