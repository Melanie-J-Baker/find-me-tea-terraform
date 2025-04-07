// Create Route53 record
resource "aws_route53_record" "ssl_cert_validation_records" {
  for_each = {
    for dvo in aws_acm_certificate.ssl_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.route53_zone_id
}

resource "aws_route53_record" "redirect" {
  zone_id = var.route53_zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.findmetea-cloudfront.domain_name
    zone_id                = "Z2FDTNDATAQYW2" // Cloudfront distribution id
    evaluate_target_health = false
  }
}

data "aws_route53_zone" "mel-baker" {
  name         = "mel-baker.co.uk"
  private_zone = false
}

resource "aws_route53_record" "custom_domain_record" {
  name = "api"
  type = "CNAME"
  ttl = "300" # TTL in seconds

  records = ["d2wko6ft2byoqu.cloudfront.net"]

  zone_id = data.aws_route53_zone.mel-baker.zone_id
}

resource "aws_route53_record" "api_ssl_cert_validation_records" {
  for_each = {
    for dvo in aws_acm_certificate.my_api_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.mel-baker.zone_id
}