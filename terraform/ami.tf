#Getting Super Mario AMI created by packer
data "aws_ami" "superMarioImage" {
  most_recent = true

  owners = ["self"]
  tags = {
    Name   = "superMarioImage"
  }
}
