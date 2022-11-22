module "hello-world" {
  source = "./modules/hello-world"
  count  = 2

  cron_expression = "* * ? * * *"
  prefix          = "hello${count.index}-"
}

output "hello-world-function-name" {
  value = module.hello-world[0].function_name
}
