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
  type    = string
  default = "us-east-1"
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "route53_zone_id" {
  type = string
}

variable "custom_domain_cloudfront_url" {
  type = string
}

variable "cloudfront_distribution_id" {
  type = string
}