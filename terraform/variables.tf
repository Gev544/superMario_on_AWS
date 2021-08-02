variable "aws_region" {
  description = "AWS region for creating resources"
}
variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "172.16.0.0/16"
}

#The public subnet is accessible and all traffic (0.0.0.0/0) is routed directly
variable "public_subnet_a_cidr" {
  description = "CIDR for the public subnet"
  default = "172.16.0.0/19"
}

variable "public_subnet_b_cidr" {
  description = "CIDR for the public subnet"
  default = "172.16.32.0/19"
}

variable "public_subnet_c_cidr" {
  description = "CIDR for the public subnet"
  default = "172.16.64.0/19"
}


#The private subnet is inaccessible to the internet (both in and out)
variable "private_subnet_a_cidr" {
  description = "CIDR for the private subnet"
  default = "172.16.96.0/19"
}

variable "private_subnet_b_cidr" {
  description = "CIDR for the private subnet"
  default = "172.16.128.0/19"
}

variable "private_subnet_c_cidr" {
  description = "CIDR for the private subnet"
  default = "172.16.160.0/19"
}

variable "key_path" {
  description = "SSH Public Key path for AWS EC2 Key Pair"
  default = "/tmp/super-mario.pub"
}
