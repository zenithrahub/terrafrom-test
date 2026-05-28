resource "aws_iam_policy" "admin_policy" {
  name = "terraform-governance-admin-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3.GetObject"
<<<<<<< HEAD
        Resource = "arn:aws:s3:::my-bucket/*"
=======
        Resource = "arn:aws:s3:::example-bucket/*"
>>>>>>> refs/remotes/origin/main
      }
    ]
  })
}
