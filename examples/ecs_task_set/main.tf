module "ecs" {
  source = "../../"

  ecs_task_sets = [{
    service         = aws_ecs_service.demo.id
    cluster         = aws_ecs_cluster.demo.id
    task_definition = aws_ecs_task_definition.demo.arn
  }]
}

resource "aws_ecs_cluster" "demo" {
  name = "demo"
}

resource "aws_ecs_task_definition" "demo" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "nginx:latest"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }
}

resource "aws_ecs_service" "demo" {
  name            = "demo"
  cluster         = aws_ecs_cluster.demo.id
  task_definition = aws_ecs_task_definition.demo.arn
}
