output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.findmetea-cloudfront.domain_name
  description = "Domain name for cloudfront distribution"
}