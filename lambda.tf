data "archive_file" "lambda_package_get_api_key" {
  type        = "zip"
  source_file = "get-api-key.js"
  output_path = "get-api-key.zip"
}

data "archive_file" "lambda_package_post_google_places_api" {
    type = "zip"
    source_file = "post-google-places-api.js"
    output_path = "post-google-places-api.zip"
}

resource "aws_lambda_function" "get_api_key_lambda" {
  filename         = "get-api-key.zip"
  function_name    = "getApiKeyLambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "get-api-key.handler"
  runtime          = "nodejs18.x"
  source_code_hash = data.archive_file.lambda_package_get_api_key.output_base64sha256
}

resource "aws_lambda_function" "post_google_places_api_lambda" {
    filename = "post-google-places-api.zip"
    function_name = "postGooglePlacesApiLambda"
    role = aws_iam_role.lambda_role.arn
    handler = "post-google-places-api.handler"
    runtime = "nodejs18.x"
    source_code_hash = data.archive_file.lambda_package_post_google_places_api.output_base64sha256
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}