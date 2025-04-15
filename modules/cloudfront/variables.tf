variable "domain_name" {
  type        = string
  description = "Name of the domain"
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

variable "api_domain_name" {
  type        = string
  description = "Name of the domain of the API"
}

variable "ssl_cert_arn" {
  type = string
  description = "SSL certificate arn"
}

variable "bucket" {
  type = string
  description = "S3 bucket"
}
