### VPC ###

# Creating a VPC for the EC2 instance.
# A VPC is a virtual network in AWS, which is logically isolated from other virtual networks in the AWS cloud.
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc.cidr_block

  tags = {
    Name = var.vpc.name
  }
}

### SUBNET ###

# Creating a subnet for the EC2 instance.
# A subnet is a range of IP addresses in your VPC.
resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.vpc.id

  cidr_block        = var.subnet.cidr_block
  availability_zone = var.subnet.availability_zone

  tags = {
    Name = var.subnet.name
  }
}

### SECURITY GROUP ###

# Creating a security group for the EC2 instance.
# A security group acts as a virtual firewall for your instance to control inbound and outbound traffic.
resource "aws_security_group" "security_group" {
  name_prefix = var.security_group.name_prefix

  dynamic "ingress" {
    for_each = var.security_group.rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}

### EC2 KEY PAIR ###

# Creating an EC2 Key Pair for SSH access to the EC2 instance.
# An EC2 Key Pair is a public/private key pair that you can use to securely connect to your instance.
resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.key_pair.name
  public_key = var.key_pair.public_key
}

### EC2 INSTANCE ###

# Fetching the latest Amazon Linux 2 AMI.
# An AMI is a template that contains a software configuration (operating system, application server, and applications).
# You use AMIs to launch instances.
data "aws_ami" "latest_amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

# Creating the actual EC2 instance.
# An EC2 instance is a virtual server in AWS.
# The instance is created in the VPC and subnet created above.
# The instance is also created with a security group that allows all traffic.
resource "aws_instance" "ec2" {
  ami           = var.ec2.ami != null ? var.ec2.ami : data.aws_ami.latest_amazon_linux_2.id
  instance_type = var.ec2.instance_type
  user_data     = var.docker.install ? file("${path.module}/setup-docker.sh") : null

  key_name               = aws_key_pair.ec2_key_pair.key_name
  subnet_id              = aws_subnet.subnet.id
  vpc_security_group_ids = [aws_security_group.security_group.id]

  tags = {
    Name = var.ec2.name
  }
}

# [Limitations] #
# Terraform is not meant to be used for deploying applications.
# Terraform is meant to be used for deploying infrastructure.
#
# Usually, tools like Ansible, Chef, Puppet, etc. are used for deploying applications.
# We believe using tools like that would be a little off the scope of this AGES project.
#
# Therefore, the frontend application and the database must be deployed separately.
# For now, these components must be deployed manually by connecting to the EC2 instance.
# that was created with Terraform through AWS EC2 console.
