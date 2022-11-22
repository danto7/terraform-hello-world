module "hello-world" {
  source = "./modules/hello-world"
  count  = 2

  cron   = "0 * * * *"
  prefix = "hello-${count.index}"
}
