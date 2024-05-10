resource "aws_s3_bucket" "remote" {
    bucket = "state-remote-store"
  
}
# resource "aws_s3_bucket_acl" "example" {
#   bucket = aws_s3_bucket.remote.id
#   acl    = "private"
# }

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.remote.id
  versioning_configuration {
    status = "Enabled"
  }
}