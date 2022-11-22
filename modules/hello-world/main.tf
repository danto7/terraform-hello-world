locals {
  function_name = "${var.prefix}hello-world"
  zip_path      = data.archive_file.zip.output_path
}

#tfsec:ignore:aws-lambda-enable-tracing
resource "aws_lambda_function" "fn" {
  filename         = local.zip_path
  source_code_hash = filebase64sha256(local.zip_path)
  description      = "Greets you."
  function_name    = local.function_name
  role             = aws_iam_role.fn.arn

  handler = "lambda.handler"
  runtime = "python3.9"
}

data "archive_file" "zip" {
  type        = "zip"
  output_path = "${path.module}/files/fn.zip"

  source {
    content  = file("${path.module}/files/lambda.py")
    filename = "lambda.py"
  }
}

resource "aws_lambda_permission" "allow_trigger" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fn.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.scheduled.arn
}

resource "aws_iam_role" "fn" {
  name = local.function_name

  assume_role_policy = data.aws_iam_policy_document.role.json
}

data "aws_iam_policy_document" "role" {
  statement {
    effect  = "Allow"
    actions = "sts:AssumeRole"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_cloudwatch_event_rule" "scheduled" {
  name                = local.function_name
  description         = "Triggers lambda ${local.function_name}"
  schedule_expression = "cron(${var.cron_expression})"
}

resource "aws_cloudwatch_event_target" "this" {
  rule = aws_cloudwatch_event_rule.scheduled.name
  arn  = aws_lambda_function.fn.arn
}
