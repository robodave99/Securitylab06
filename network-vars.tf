variable "role_name" {
  default = "my-role"
}

variable "policy_name" {
  default = "my-policy"
}

variable "policy_document" {
  default = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}
