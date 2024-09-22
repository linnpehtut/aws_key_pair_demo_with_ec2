# AWS Key Pair, VPC, IGW, Subnet, Route Table, Security Group, EC2 with Terraform
This repository contains Terraform configurations to create keypair, vpc, internet gateway, subnet, route table, security group and ec2 on AWS.

## Overview

- Create an AWS keypair with a unique name using a random string.
- Saves the private key on the local device.
- Create VPC, IGW, Subnet, Route Table, Security Group & EC2 instance to test login using earlier created keypair.
- Uses only Terraform to manage the whole infrastructure.

## Prereqisites

- AWS CLI configured with appropriate permissions
- Terraform installed

## Setup

1. Configure AWS CLI:
   ```
   aws configure --profile <profile_name>
   ```
   Enter your Access Key, Secret Access Key, default region, and output format.

2. Ensure the IAM user/role has the required permissions to create resources.

##File Structure

- `variables.tf`: Declares input variables used throughout the configuration.
- `infra.tf`: Contains the configuration for AWS infrastructure, including VPC, subnets, internet gateway, route tables, security groups, and EC2 instances.
- `output.tf`: Defines output variables to display important information after Terraform applies
- `terraform.tfvars.example`: Example file to set values for the defined variables, allowing customization of the deployment.

## Key Components

### Random String Generation

Generates a random string of 8 characters (excluding special characters) to be used as a suffix for the deployment ID, ensuring uniqueness in resource naming.

### SSH Key Generation

Uses tls_private_key to generate a 4096-bit RSA private key, which is securely stored with local_sensitive_file. It then creates an AWS key pair using the generated public key, enabling secure SSH access to EC2 instances.

### AWS Infrastructure

Setup Virtual Private Cloud (VPC) with an associated Internet Gateway, a public subnet, and a route table to enable internet access. It also includes a route table association and a security group that allows all inbound and outbound traffic for SSH access to EC2 instances.

### AMI Retrieval and EC2 Instance Creation

Retrieves the most recent AMI ID for the Ubuntu Jammy 22.04 server using specified filters. It then creates an EC2 instance with the retrieved AMI, associating it with the designated VPC, security group, and subnet while ensuring public IP address assignment.

## Providers

- `hashicorp/aws` (5.67.0)
- `hashicorp/random`
- `hashicorp/tls`
- `hashicorp/local`

## Usage

1. Initialize Terraform:
   ```
   terraform init
   ```

2. Format and validate the configuration:
   ```
   terraform fmt
   terraform validate
   ```

3. Plan the changes:
   ```
   terraform plan
   ```

4. Apply the changes:
   ```
   terraform apply
   ```
After applying the configuration:
- `generated` directory is created containing the private SSH key
-  Key Pair, VPC, IGW, Subnet, Route Table, Security Group, EC2 will be created on AWS.
-  use the private SSH key in `generated` directory to SSH into the EC2.


