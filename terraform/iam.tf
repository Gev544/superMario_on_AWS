data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}

# SSM
data "aws_iam_policy" "amazonssmmanagedinstancecore" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "sm_app_role" {
  name = "sm-app.role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "sm_app_profile" {
  name = "sm-app.profile"
  role = aws_iam_role.sm_app_role.name
}

# SSM
resource "aws_iam_role_policy_attachment" "amazonssmmanagedinstancecore-roleattachment" {
  policy_arn = data.aws_iam_policy.amazonssmmanagedinstancecore.arn
  role = aws_iam_role.sm_app_role.name
}