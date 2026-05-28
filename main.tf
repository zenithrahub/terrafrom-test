resource "aws_s3_bucket" "public_bucket" {
  bucket = "terraform-governance-demo-bucket-12345"

  tags = {
    Name = "public-governance-demo"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.public_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
