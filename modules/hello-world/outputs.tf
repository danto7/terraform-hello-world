output "function_name" {
  description = "The function name of the lambda that got created."
  value       = try(aws_lambda_function.fn[0].function_name, null)
}
