resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.bucket_name}-${var.environment}"
  acl           = var.private
  force_destroy = true

  # use AWS SSE to encrypt
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    environment = "${var.environment}"
  }
}
