variable "route53_zone_id" {
  type        = string
  description = "Route 53 zone ID"
}

variable "domain_name" {
  type        = string
  description = "Name of the domain"
}

variable "cloudfront_distribution_id" {
  type        = string
  description = "Amazon CloudFront distribution ID"
}

variable "custom_domain_cloudfront_url" {
  type        = string
  description = "Amazon CloudFront custom domain URL"
}

variable "api_domain_name" {
  type        = string
  description = "Name of the domain of the API"
}

variable "bucket_name" {
  type        = string
  description = "Name of the bucket."
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region which resources will be created in"
}

variable "ssl_cert_domain_validation_options" {
  type = list
  description = "SSL certificate domain validation options"
}

variable "my_api_cert_domain_validation_options" {
  type = list
  description = "SSL certifcate domain validation options for API"
}

variable "cloudfront_domain_name" {
  type = string
  description = "Domain name for cloudfront distribution"
}

variable "api_cloudfront_custom_domain_name" {
  type = string
  description = "Custom domain name for API cloudfront"
}

variable "api_cloudfront_zone_id" {
  type = string
  description = "API Gateway cloudfront zone ID"
}