output "api_execution_arn" {
  value       = aws_api_gateway_rest_api.find_me_tea_api.execution_arn
  description = "Execution arn for API"
}

output "get_api_key_lambda_invoke_arn" {
  value       = aws_lambda_function.get_api_key_lambda.invoke_arn
  description = "Invoke arn for lambda function to get api key"
}

output "post_google_places_api_lambda_invoke_arn" {
  value       = aws_lambda_function.post_google_places_api_lambda.invoke_arn
  description = "Invoke arn for lambda function to get api key"
}

output "api_cloudfront_custom_domain_name" {
  value = aws_api_gateway_domain_name.custom_domain.cloudfront_domain_name
  description = "API Gateway cloudfront custom domain name"
}

output "api_cloudfront_zone_id" {
  value = aws_api_gateway_domain_name.custom_domain.cloudfront_zone_id
  description = "API Gateway cloudfront zone ID"
}