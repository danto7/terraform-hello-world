module "hello-world" {
  source = "./modules/hello-world"
  count  = 2

  cron_expression = "* * ? * * *"
  prefix          = "hello${count.index}-"
}
