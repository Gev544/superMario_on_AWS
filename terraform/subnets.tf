#Here we are defining our private subnet
#The private subnet is inaccessible to the internet (both in and out)
resource "aws_subnet" "sm-private-subnet-a" {
  vpc_id = "${aws_vpc.sm-vpc.id}"
  cidr_block = "${var.private_subnet_a_cidr}"
  map_public_ip_on_launch = false
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "sm-private-subnet"
    Owner = "gabovyan"
  }
}

resource "aws_subnet" "sm-private-subnet-b" {
  vpc_id = "${aws_vpc.sm-vpc.id}"
  cidr_block = "${var.private_subnet_b_cidr}"
  map_public_ip_on_launch = false
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "sm-private-subnet"
    Owner = "gabovyan"
  }
}

resource "aws_subnet" "sm-private-subnet-c" {
  vpc_id = "${aws_vpc.sm-vpc.id}"
  cidr_block = "${var.private_subnet_c_cidr}"
  map_public_ip_on_launch = false
  availability_zone = "${var.aws_region}c"

  tags = {
    Name = "sm-private-subnet"
    Owner = "gabovyan"
  }
}


#Here we are defining our public subnet
#The public subnet is accessible and all traffic (0.0.0.0/0) is routed directly
resource "aws_subnet" "sm-public-subnet-a" {
  vpc_id = "${aws_vpc.sm-vpc.id}"
  cidr_block = "${var.public_subnet_a_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "sm-public-subnet"
    Owner = "gabovyan"
  }
}

resource "aws_subnet" "sm-public-subnet-b" {
  vpc_id = "${aws_vpc.sm-vpc.id}"
  cidr_block = "${var.public_subnet_b_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "sm-public-subnet"
    Owner = "gabovyan"
  }
}

resource "aws_subnet" "sm-public-subnet-c" {
  vpc_id = "${aws_vpc.sm-vpc.id}"
  cidr_block = "${var.public_subnet_c_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "${var.aws_region}c"

  tags = {
    Name = "sm-public-subnet"
    Owner = "gabovyan"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "sm-rt-a" {
  subnet_id = "${aws_subnet.sm-public-subnet-a.id}"
  route_table_id = "${aws_route_table.sm-rt.id}"
}

resource "aws_route_table_association" "sm-rt-b" {
  subnet_id = "${aws_subnet.sm-public-subnet-b.id}"
  route_table_id = "${aws_route_table.sm-rt.id}"
}

resource "aws_route_table_association" "sm-rt-c" {
  subnet_id = "${aws_subnet.sm-public-subnet-c.id}"
  route_table_id = "${aws_route_table.sm-rt.id}"
}

# Assign the route table to the private Subnet
resource "aws_route_table_association" "sm-rt-a-priv" {
  subnet_id = "${aws_subnet.sm-private-subnet-a.id}"
  route_table_id = "${aws_route_table.sm-rt.id}"
}

resource "aws_route_table_association" "sm-rt-b-priv" {
  subnet_id = "${aws_subnet.sm-private-subnet-b.id}"
  route_table_id = "${aws_route_table.sm-rt.id}"
}

resource "aws_route_table_association" "sm-rt-c-priv" {
  subnet_id = "${aws_subnet.sm-private-subnet-c.id}"
  route_table_id = "${aws_route_table.sm-rt.id}"
}