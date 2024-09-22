variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "deployment_name" {
  type    = string
  default = "test-deployment"
}

variable "create_ec2_ssh_keypair" {
  type    = bool
  default = true
}

variable "ec2_ssh_keypair_name" {
  type    = string
  default = "test-deployment"
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "aws_zone" {
  type    = string
  default = "ap-southeast-1a"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}