# Define SSH key pair for our instances
resource "aws_key_pair" "sm-key" {
  key_name = "sm-key"
  public_key = "${file("${var.key_path}")}"

  tags = {
    Name = "sm-key"
    Owner = "gabovyan"
  }
}