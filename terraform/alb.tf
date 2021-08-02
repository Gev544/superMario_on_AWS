#Creating ALB for super-mario instance
resource "aws_alb" "sm-alb" {
  name            = "sm-alb"
  security_groups = ["${aws_security_group.super-mario-sg.id}"]
  subnets         = ["${aws_subnet.sm-private-subnet-a.id}","${aws_subnet.sm-private-subnet-b.id}","${aws_subnet.sm-private-subnet-c.id}"]
  tags = {
    Name = "sm-alb"
    owner = "gabovyan"
  }
}

#Tagret Group for backend ALB
resource "aws_alb_target_group" "sm-targetgroup" {
  name     = "sm-targetgroup"
  port     = 8600
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.sm-vpc.id}"
  tags = {
    Name = "sm-targetgroup"
    owner = "gabovyan"
  }

  #health check
    health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    protocol            = "HTTP"
    port                = "8600"
  }
}

#listeners rules
resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = "${aws_alb.sm-alb.arn}"
  port              = "80"
  protocol          = "HTTP"

    default_action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.sm-targetgroup.arn}"


  }
}




#Instance Attachment
resource "aws_alb_target_group_attachment" "attachment-replica-target" {
  target_group_arn = "${aws_alb_target_group.sm-targetgroup.arn}"
  target_id        = "${aws_instance.sm-replica.id}"
  port             = 8600
}

resource "aws_alb_target_group_attachment" "attachment-master-target" {
  target_group_arn = "${aws_alb_target_group.sm-targetgroup.arn}"
  target_id        = "${aws_instance.sm-master.id}"
  port             = 8600
}