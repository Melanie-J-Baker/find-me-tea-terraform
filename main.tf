terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
}

module "cloudfront" {
  source = "./modules/cloudfront"

  bucket_name     = var.bucket_name
  region          = var.region
  domain_name     = var.domain_name
  api_domain_name = var.domain_name
  ssl_cert_arn    = module.acm.ssl_cert_arn
  bucket          = module.s3.bucket
}

module "dns" {
  source = "./modules/dns"

  route53_zone_id                       = var.route53_zone_id
  domain_name                           = var.domain_name
  cloudfront_distribution_id            = var.cloudfront_distribution_id
  custom_domain_cloudfront_url          = var.custom_domain_cloudfront_url
  api_domain_name                       = var.api_domain_name
  bucket_name                           = var.bucket_name
  ssl_cert_domain_validation_options    = module.acm.ssl_cert_domain_validation_options
  my_api_cert_domain_validation_options = module.acm.my_api_cert_domain_validation_options
  cloudfront_domain_name                = module.cloudfront.cloudfront_domain_name
  api_cloudfront_custom_domain_name     = module.api.api_cloudfront_custom_domain_name
  api_cloudfront_zone_id                = module.api.api_cloudfront_zone_id
}

module "acm" {
  source = "./modules/acm"

  domain_name     = var.domain_name
  api_domain_name = var.api_domain_name
}

module "api" {
  source = "./modules/api"

  api_domain_name = var.api_domain_name
  domain_name     = var.domain_name
  google_api_key  = var.google_api_key
  my_api_cert_arn = module.acm.my_api_cert_arn
}