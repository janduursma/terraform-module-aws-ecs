module "ecs" {
  source = "../../"

  ecs_tags = [{
    resource_arn = "demo"
    key          = "Name"
    value        = "Hello World"
  }]
}

resource "aws_batch_compute_environment" "demo" {
  name         = "demo"
  service_role = data.aws_iam_role.demo.arn
  type         = "UNMANAGED"
}
