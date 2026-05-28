resource "aws_iam_policy" "admin_policy" {
  name = "terraform-governance-admin-policy"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect   = "Allow"
<<<<<<< HEAD
        Action   = "*"
        Resource = "arn:aws:s3:::example-bucket/*"
=======
        Action   = "s3.GetObject"
        Resource = "arn:aws:s3:::my-bucket/*"
>>>>>>> 5a0bde6 (Changes)
      }
    ]
  })
}
