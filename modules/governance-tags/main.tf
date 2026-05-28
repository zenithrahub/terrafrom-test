resource "aws_s3_bucket" "governance_bucket" {

  bucket = "${var.environment}-governance-demo-bucket"

  tags = {
    Environment = var.environment
  }
}
