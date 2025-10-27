module "ecs" {
  source = "../../"

  ecs_cluster_capacity_providers = {
    capacity_providers = ["FARGATE"]
    cluster_name       = aws_ecs_cluster.demo.name

    default_capacity_provider_strategies = [{
      capacity_provider = "FARGATE"
      base              = 1
      weight            = 40
      }, {
      capacity_provider = "FARGATE_SPOT"
      base              = 1
      weight            = 60
    }]
  }
}

resource "aws_ecs_cluster" "demo" {
  name = "demo"
}

