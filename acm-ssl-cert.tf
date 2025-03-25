// Create SSL certificate
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