# creating the IAM role
resource "aws_iam_role" "my_role" {
  name               = var.role_name
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
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

# Creating an iam instance profile
resource "aws_iam_instance_profile" "my_instance_profile" {
  name = "my_instance_profile"

  role = aws_iam_role.my_role.name
}

# creating the EC2 instance with the IAM role
resource "aws_instance" "my_instance" {
  ami           = "ami-01387af90a62e3c01"
  instance_type = "t2.micro"

  iam_instance_profile = aws_iam_instance_profile.my_instance_profile.name

  tags = {
    Name = "MyEC2Instance"
  }
}

#detaching the iam policy from the role
resource "aws_iam_policy_attachment" "detach_policy" {
  name       = var.policy_name
  policy_arn = aws_iam_policy.my_policy.arn
  roles      = [aws_iam_role.my_role.name]
}
