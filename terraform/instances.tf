#super-mario master instance
resource "aws_instance" "sm-master" {
  ami = "${data.aws_ami.superMarioImage.id}"
  key_name = aws_key_pair.sm-key.id
  subnet_id = aws_subnet.sm-public-subnet-a.id
  associate_public_ip_address = false
  source_dest_check = false
  iam_instance_profile = "${aws_iam_instance_profile.sm_app_profile.name}"
  instance_type = "t2.micro"
  root_block_device {
    delete_on_termination = true
    volume_type = "standard"
  }
  vpc_security_group_ids = [aws_security_group.super-mario-sg.id]
  tags = {
        Name  = "sm-master"
        owner = "gabovyan"
 }

}

#super-mario replica instance
resource "aws_instance" "sm-replica" {
  ami = "${data.aws_ami.superMarioImage.id}"
  key_name = aws_key_pair.sm-key.id
  subnet_id = aws_subnet.sm-public-subnet-a.id
  associate_public_ip_address = false
  source_dest_check = false
  iam_instance_profile = "${aws_iam_instance_profile.sm_app_profile.name}"
  instance_type = "t2.micro"
  root_block_device {
    delete_on_termination = true
    volume_size = 40
    volume_type = "standard"
  }
  vpc_security_group_ids = [aws_security_group.super-mario-sg.id]
  tags = {
        Name  = "sm-replica"
        owner = "gabovyan"
 }

}

