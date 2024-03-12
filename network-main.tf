#creating the iam role
resource "aws_iam_role" "my_role" {
  name               = var.role_name
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF
}

#defining the iam policy
resource "aws_iam_policy" "my_policy" {
  name        = var.policy_name
  description = "My policy"
  policy      = var.policy_document
}

#attaching the iam policy to the role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.my_role.name
  policy_arn = aws_iam_policy.my_policy.arn
}

#detaching the iam policy from the role
resource "aws_iam_policy_attachment" "detach_policy" {
  name       = var.policy_name
  policy_arn = aws_iam_policy.my_policy.arn
  roles      = [aws_iam_role.my_role.name]
}
