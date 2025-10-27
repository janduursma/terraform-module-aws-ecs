module "ecs" {
  source = "../../"

  ecs_account_setting_defaults = [
    {
      name  = "taskLongArnFormat"
      value = "enabled"
    }
  ]
}

