output "my_api_cert_arn" {
  value       = aws_acm_certificate.my_api_cert.arn
  description = "SSL certificate arn for API"
}

output "ssl_cert_arn" {
  value       = aws_acm_certificate.ssl_cert.arn
  description = "SSL certificate arn for Cloudfront"
}

output "ssl_cert_domain_validation_options" {
  value       = aws_acm_certificate.ssl_cert.domain_validation_options
  description = "SSL certificate domain validation options for Cloudfront"
}

output "my_api_cert_domain_validation_options" {
  value       = aws_acm_certificate.my_api_cert.domain_validation_options
  description = "SSL certificate domain validation options for API"
}