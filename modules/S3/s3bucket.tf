resource "aws_s3_bucket" "s3_bucket" {
  
  bucket = "terraform-statefile-ranjith"
  tags = {
    Name        = "MyS3Bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "version_enable" {
  
  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}
