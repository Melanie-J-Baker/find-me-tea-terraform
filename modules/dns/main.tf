// Create Route53 records

resource "aws_route53_record" "ssl_cert_validation_records" {
  for_each = {
    for dvo in var.ssl_cert_domain_validation_options : dvo.domain_name => {
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
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_distribution_id
    evaluate_target_health = false
  }
}

data "aws_route53_zone" "mel-baker" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "custom_domain_record" {
  zone_id = data.aws_route53_zone.mel-baker.zone_id
  name    = "api"
  type    = "A"

  alias {
    name                   = var.api_cloudfront_custom_domain_name
    zone_id                = var.api_cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "api_ssl_cert_validation_records" {
  for_each = {
    for dvo in var.my_api_cert_domain_validation_options : dvo.domain_name => {
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