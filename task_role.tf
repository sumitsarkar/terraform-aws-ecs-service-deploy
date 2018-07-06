resource "aws_iam_role" "test_role" {
  name = "${var.service_name}-${var.environment}-task-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# One can create any IAM policies, make sure they have a unique name or simply use the AWS managed policy as data
# fields and attach them to the task role.

