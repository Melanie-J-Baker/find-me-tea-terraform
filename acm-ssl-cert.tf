// Create SSL certificate for main domain
resource "aws_acm_certificate" "ssl_cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name = "find_me_tea"
  }

  lifecycle {
    create_before_destroy = true
  }
}

// Create SSL certifcate for API domain
resource "aws_acm_certificate" "my_api_cert" {
  domain_name               = "api.mel-baker.co.uk"
  provider                  = aws
  subject_alternative_names = ["api.mel-baker.co.uk"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}