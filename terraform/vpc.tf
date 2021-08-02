#Here we are defining our VPC
resource "aws_vpc" "sm-vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "sm-vpc"
    Owner = "gabovyan"
  }
}

#Here we are defining our internet gateway for the VPC
resource "aws_internet_gateway" "sm-igw" {
  vpc_id = "${aws_vpc.sm-vpc.id}"

  tags = {
    Name = "sm-igw"
    Owner = "gabovyan"
  }
}

#Here we are defining our route table for the internet gateway
resource "aws_route_table" "sm-rt" {
  vpc_id = "${aws_vpc.sm-vpc.id}"

  tags = {
    Name = "sm-rt"
    Owner = "gabovyan"
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.sm-vpc.id
  route_table_id = aws_route_table.sm-rt.id
}

# Create the Internet Access
resource "aws_route" "sm_vpc_internet_access" {
  route_table_id         = aws_route_table.sm-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sm-igw.id
}