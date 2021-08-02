#sec group for super mario server
  resource "aws_security_group" "super-mario-sg" {
    name = "super-mario-sg"
    description = "Allow incoming tcp:8600 connections & SSH access"

    ingress {
      from_port = 8600
      to_port = 8600
      protocol = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"]
    }

    ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"]
    }
        ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = [
        "0.0.0.0/0"]
    }

    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [
        "0.0.0.0/0"]
    }

    vpc_id = aws_vpc.sm-vpc.id

    tags = {
      Name = "super-mario-sg"
      Owner = "gabovyan"
    }
  }