resource "aws_api_gateway_rest_api" "find_me_tea_api" {
  name        = "find_me_tea_api"
  description = "API Gateway for Find Me Tea app"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

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
  integration_http_method = "GET"
  type                    = "MOCK"
}

resource "aws_api_gateway_method_response" "get_api_key" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id = aws_api_gateway_resource.google-maps-api-key.id
  http_method = aws_api_gateway_method.get_api_key.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "get_api_key" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id = aws_api_gateway_resource.google-maps-api-key.id
  http_method = aws_api_gateway_method.get_api_key.http_method
  status_code = aws_api_gateway_method_response.get_api_key.status_code

  depends_on = [
    aws_api_gateway_method.get_api_key,
    aws_api_gateway_integration.get_api_key_lambda_integration
  ]
}

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
  type                    = "MOCK"
}

resource "aws_api_gateway_method_response" "post_google_places_api" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id = aws_api_gateway_resource.search.id
  http_method = aws_api_gateway_method.post_google_places_api.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "post_google_places_api" {
  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  resource_id = aws_api_gateway_resource.search.id
  http_method = aws_api_gateway_method.post_google_places_api.http_method
  status_code = aws_api_gateway_method_response.post_google_places_api.status_code

  depends_on = [
    aws_api_gateway_method.post_google_places_api,
    aws_api_gateway_integration.post_google_places_api_lambda_integration
  ]
}

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

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.get_api_key_lambda_integration,
    aws_api_gateway_integration.options_search_lambda_integration,
    aws_api_gateway_integration.post_google_places_api_lambda_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.find_me_tea_api.id
  stage_name  = "dev"
}