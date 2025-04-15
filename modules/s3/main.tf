// Create s3 bucket

resource "aws_s3_bucket" "bucket-1" {
  bucket = "www.${var.bucket_name}"
}

data "aws_s3_bucket" "selected-bucket" {
  bucket = aws_s3_bucket.bucket-1.bucket
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = data.aws_s3_bucket.selected-bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
  depends_on = [aws_s3_bucket_public_access_block.example]
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = data.aws_s3_bucket.selected-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = data.aws_s3_bucket.selected-bucket.id
  policy = data.aws_iam_policy_document.iam-policy-1.json
}

data "aws_iam_policy_document" "iam-policy-1" {
  statement {
    sid    = "AllowPublicRead"
    effect = "Allow"
    resources = [
      "arn:aws:s3:::www.${var.bucket_name}",
      "arn:aws:s3:::www.${var.bucket_name}/*",
    ]
    actions = ["s3:GetObject"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }

  depends_on = [aws_s3_bucket_public_access_block.example]
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  bucket     = data.aws_s3_bucket.selected-bucket.id
  acl        = "public-read"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

// Confugure s3 bucket to enable static website hosting
resource "aws_s3_bucket_website_configuration" "website-config" {
  bucket = data.aws_s3_bucket.selected-bucket.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = data.aws_s3_bucket.selected-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

// Website file uploads

resource "aws_s3_object" "object-upload-html" {
  for_each     = fileset("uploads/", "*.html")
  bucket       = data.aws_s3_bucket.selected-bucket.bucket
  key          = each.value
  source       = "uploads/${each.value}"
  content_type = "text/html"
  etag         = filemd5("uploads/${each.value}")
}

resource "aws_s3_object" "object-upload-css" {
  for_each     = fileset("uploads/assets/", "*.css")
  bucket       = data.aws_s3_bucket.selected-bucket.bucket
  key          = "assets/${each.value}"
  source       = "uploads/assets/${each.value}"
  content_type = "text/css"
  etag         = filemd5("uploads/assets/${each.value}")
}

resource "aws_s3_object" "object-upload-js" {
  for_each     = fileset("uploads/assets/", "*.js")
  bucket       = data.aws_s3_bucket.selected-bucket.bucket
  key          = "assets/${each.value}"
  source       = "uploads/assets/${each.value}"
  content_type = "text/javascript"
  etag         = filemd5("uploads/assets/${each.value}")
}

resource "aws_s3_object" "object-upload-png" {
  for_each     = fileset("uploads/assets/", "*.png")
  bucket       = data.aws_s3_bucket.selected-bucket.bucket
  key          = "assets/${each.value}"
  source       = "uploads/assets/${each.value}"
  content_type = "image/png"
  etag         = filemd5("uploads/assets/${each.value}")
}


