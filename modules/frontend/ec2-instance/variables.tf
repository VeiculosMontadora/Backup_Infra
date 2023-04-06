# Variables regarding the VPC.
variable "vpc" {
  type = object({
    cidr_block = optional(string, "10.0.0.0/16")
    name       = string
  })
  description = "Specifications for the VPC."
}

# Variables regarding the Subnet.
variable "subnet" {
  type = object({
    cidr_block        = optional(string, "10.0.1.0/24")
    name              = string
    availability_zone = string
  })
  description = "Specifications for the Subnet."
}

# Variables regarding the Security Group.
# The default security group allows all traffic.
variable "security_group" {
  type = object({
    name_prefix = string
    rules = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  })
  default = {
    name_prefix = "allow_all"
    rules = [
      {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }
  description = "Specifications for the Security Group."
}

# Variables regarding the EC2 Key Pair.
variable "key_pair" {
  type = object({
    name       = string
    public_key = string
  })
  sensitive   = true
  description = "Specifications for the EC2 Key Pair."
}

# Variables regarding the EC2 Instance.
variable "ec2" {
  type = object({
    ami           = optional(string)
    instance_type = optional(string, "t3.micro")
    name          = string
  })
  description = "Specifications for the EC2 Instance."
}

# Variables regarding the Docker installation.
variable "docker" {
  type = object({
    install = bool
  })
  default = {
    install = true
  }
  description = "Specifications for Docker."
}
