module "ecs" {
  source = "../../"

  ecs_task_definition = {
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
    }])
  }
}
