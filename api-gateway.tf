# REST API

resource "aws_api_gateway_rest_api" "find_me_tea_api" {
  name        = "find_me_tea_api"
  description = "API Gateway for Find Me Tea app"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# GET - Google Maps API key

resource "aws_api_gateway_resource" "google-maps-api-key" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  parent_id   = aws_api_gateway_rest_api.find_me_tea_api.root_resource_id
  path_part   = "google-maps-api-key"
}

resource "aws_api_gateway_method" "get_api_key" {
  rest_api_id   = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id   = aws_api_gateway_resource.google-maps-api-key.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_api_key_lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id             = aws_api_gateway_resource.google-maps-api-key.id
  http_method             = aws_api_gateway_method.get_api_key.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.get_api_key_lambda.invoke_arn
}

resource "aws_api_gateway_method_response" "get_api_key" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id = aws_api_gateway_resource.google-maps-api-key.id
  http_method = aws_api_gateway_method.get_api_key.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "get_api_key" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id = aws_api_gateway_resource.google-maps-api-key.id
  http_method = aws_api_gateway_method.get_api_key.http_method
  status_code = aws_api_gateway_method_response.get_api_key.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.get_api_key,
    aws_api_gateway_integration.get_api_key_lambda_integration
  ]
}

# OPTIONS - Google Maps API Key

resource "aws_api_gateway_method" "options_get_api_key" {
  rest_api_id   = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id   = aws_api_gateway_resource.google-maps-api-key.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options_get_api_key_lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id             = aws_api_gateway_resource.google-maps-api-key.id
  http_method             = aws_api_gateway_method.options_get_api_key.http_method
  integration_http_method = "OPTIONS"
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "options_get_api_key_response" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id = aws_api_gateway_resource.google-maps-api-key.id
  http_method = aws_api_gateway_method.options_get_api_key.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "options_get_api_key_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id = aws_api_gateway_resource.google-maps-api-key.id
  http_method = aws_api_gateway_method.options_get_api_key.http_method
  status_code = aws_api_gateway_method_response.options_get_api_key_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.options_get_api_key,
    aws_api_gateway_integration.options_get_api_key_lambda_integration
  ]
}

# POST - Google Places API (Nearby Search)

resource "aws_api_gateway_resource" "search" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  parent_id   = aws_api_gateway_rest_api.find_me_tea_api.root_resource_id
  path_part   = "search"
}

resource "aws_api_gateway_method" "post_google_places_api" {
  rest_api_id   = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id   = aws_api_gateway_resource.search.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "post_google_places_api_lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id             = aws_api_gateway_resource.search.id
  http_method             = aws_api_gateway_method.post_google_places_api.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.post_google_places_api_lambda.invoke_arn
}

resource "aws_api_gateway_method_response" "post_google_places_api" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id = aws_api_gateway_resource.search.id
  http_method = aws_api_gateway_method.post_google_places_api.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "post_google_places_api" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id = aws_api_gateway_resource.search.id
  http_method = aws_api_gateway_method.post_google_places_api.http_method
  status_code = aws_api_gateway_method_response.post_google_places_api.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.post_google_places_api,
    aws_api_gateway_integration.post_google_places_api_lambda_integration
  ]
}

# OPTIONS - Google Places API (Nearby Search)

resource "aws_api_gateway_method" "options_search" {
  rest_api_id   = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id   = aws_api_gateway_resource.search.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options_search_lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id             = aws_api_gateway_resource.search.id
  http_method             = aws_api_gateway_method.options_search.http_method
  integration_http_method = "OPTIONS"
  type                    = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "options_search_response" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id = aws_api_gateway_resource.search.id
  http_method = aws_api_gateway_method.options_search.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "options_search_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id = aws_api_gateway_resource.search.id
  http_method = aws_api_gateway_method.options_search.http_method
  status_code = aws_api_gateway_method_response.options_search_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.options_search,
    aws_api_gateway_integration.options_search_lambda_integration
  ]
}

# Stage, Deployment, Custom Domain Name, and Base Path Mapping

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.get_api_key_lambda_integration,
    aws_api_gateway_integration.options_get_api_key_lambda_integration,
    aws_api_gateway_integration.options_search_lambda_integration,
    aws_api_gateway_integration.post_google_places_api_lambda_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  stage_name  = "dev"
}

resource "aws_api_gateway_domain_name" "custom_domain" {
  domain_name     = var.api_domain_name
  certificate_arn = aws_acm_certificate.my_api_cert.arn
  security_policy = "TLS_1_2"
}

resource "aws_api_gateway_base_path_mapping" "gateway_mapping" {
  domain_name = var.api_domain_name
  api_id      = aws_api_gateway_rest_api.find_me_tea_api.id
  stage_name  = "dev"
}