variable "domain_name" {
  type        = string
  description = "Name of the domain"
}
variable "bucket_name" {
  type        = string
  description = "Name of the bucket."
}
variable "region" {
  type    = string
  default = "eu-west-2"
}
variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}