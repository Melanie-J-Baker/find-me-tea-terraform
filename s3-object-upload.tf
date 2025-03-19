resource "aws_s3_object" "object-upload-html" {
  for_each     = fileset("uploads/", "*.html")
  bucket       = data.aws_s3_bucket.selected-bucket.bucket
  key          = each.value
  source       = "uploads/${each.value}"
  content_type = "text/html"
  etag         = filemd5("uploads/${each.value}")
  acl          = "public-read"
}

resource "aws_s3_object" "object-upload-css" {
  for_each     = fileset("uploads/assets/", "*.css")
  bucket       = data.aws_s3_bucket.selected-bucket.bucket
  key          = each.value
  source       = "uploads/assets/${each.value}"
  content_type = "text/css"
  etag         = filemd5("uploads/assets/${each.value}")
  acl          = "public-read"
}

resource "aws_s3_object" "object-upload-js" {
  for_each     = fileset("uploads/assets/", "*.js")
  bucket       = data.aws_s3_bucket.selected-bucket.bucket
  key          = each.value
  source       = "uploads/assets/${each.value}"
  content_type = "text/javascript"
  etag         = filemd5("uploads/assets/${each.value}")
  acl          = "public-read"
}

resource "aws_s3_object" "object-upload-png" {
  for_each     = fileset("uploads/assets/", "*.png")
  bucket       = data.aws_s3_bucket.selected-bucket.bucket
  key          = each.value
  source       = "uploads/assets/${each.value}"
  content_type = "image/png"
  etag         = filemd5("uploads/assets/${each.value}")
  acl          = "public-read"
}
