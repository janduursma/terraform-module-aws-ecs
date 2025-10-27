module "ecs" {
  source = "../../"

  ecs_cluster = {
    name = "demo"

    setting = {
      name  = "containerInsights"
      value = "enabled"
    }
  }
}
