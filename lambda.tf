# Zip Lambda Files

data "archive_file" "lambda_package_get_api_key" {
  type        = "zip"
  source_file = "get-api-key.js"
  output_path = "get-api-key.zip"
}

data "archive_file" "lambda_package_post_google_places_api" {
  type        = "zip"
  source_file = "post-google-places-api.js"
  output_path = "post-google-places-api.zip"
}

# Lambda Functions

resource "aws_lambda_function" "get_api_key_lambda" {
  filename         = "get-api-key.zip"
  function_name    = "getApiKeyLambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "get-api-key.handler"
  runtime          = "nodejs18.x"
  source_code_hash = data.archive_file.lambda_package_get_api_key.output_base64sha256

  environment {
    variables = {
      google_api_key = "AIzaSyCkMDPk6ujbCI0QPG28FlTgTF4kUeZtxCw"
    }
  }
}

resource "aws_lambda_function" "post_google_places_api_lambda" {
  filename         = "post-google-places-api.zip"
  function_name    = "postGooglePlacesApiLambda"
  role             = aws_iam_role.lambda_role.arn
  handler          = "post-google-places-api.handler"
  runtime          = "nodejs18.x"
  source_code_hash = data.archive_file.lambda_package_post_google_places_api.output_base64sha256
  environment {
    variables = {
      google_api_key = "AIzaSyCkMDPk6ujbCI0QPG28FlTgTF4kUeZtxCw"
    }
  }
}

# Permissions

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

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

resource "aws_iam_role_policy" "lambda_execution_policy" {
  name = "lambda_execution_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "lambda:InvokeFunction"
        ]
        Effect   = "Allow"
        Resource = aws_lambda_function.get_api_key_lambda.arn
      },
      {
        Action = [
          "lambda:InvokeFunction"
        ]
        Effect   = "Allow"
        Resource = aws_lambda_function.post_google_places_api_lambda.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

resource "aws_lambda_permission" "apigw_lambda_get_api_key" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_api_key_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.find_me_tea_api.execution_arn}/*/GET/google-maps-api-key"
}

resource "aws_lambda_permission" "apigw_lambda_post_google_places_api" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.post_google_places_api_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.find_me_tea_api.execution_arn}/*/POST/search"
}