variable "domain_name" {
  type        = string
  description = "Name of the domain"
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

variable "access_key" {
  type        = string
  description = "AWS access key"
}

variable "secret_key" {
  type        = string
  description = "AWS secret key"
}

variable "zone_id" {
  type        = string
  description = "Amazon S3 zone ID"
}

variable "route53_zone_id" {
  type        = string
  description = "Route 53 zone ID"
}

variable "custom_domain_cloudfront_url" {
  type        = string
  description = "Amazon CloudFront custom domain URL"
}

variable "cloudfront_distribution_id" {
  type        = string
  description = "Amazon CloudFront distribution ID"
}

variable "google_api_key" {
  type        = string
  description = "Google Places API key"
}