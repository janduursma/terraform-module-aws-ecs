module "ecs" {
  source = "../../"

  ecs_capacity_providers = [
    {
      name = "demo"

      auto_scaling_group_provider = {
        auto_scaling_group_arn         = aws_autoscaling_group.demo.arn
        managed_termination_protection = "ENABLED"

        managed_scaling = {
          maximum_scaling_step_size = 1000
          minimum_scaling_step_size = 1
          status                    = "ENABLED"
          target_capacity           = 10
        }
      }
    }
  ]
}

resource "aws_autoscaling_group" "demo" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.demo.id
    version = aws_launch_template.demo.latest_version
  }

  tag {
    key                 = "Key"
    value               = "Value"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }
}

resource "aws_launch_template" "demo" {
  name_prefix   = "demo"
  image_id      = data.aws_ami_ids.demo.ids[0]
  instance_type = "c5.large"
}
