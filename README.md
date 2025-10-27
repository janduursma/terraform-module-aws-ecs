# AWS ECS Terraform module

Terraform module which creates ECS resources on AWS.

## Available Features

- Account settings
- Capacity providers
- Cluster
- Cluster capacity providers
- Service
- Tags
- Task definition
- Task set

## Examples:

- [Account settings](https://github.com/janduursma/terraform-module-aws-ecs/tree/main/examples/ecs_account_setting)
- [Capacity providers](https://github.com/janduursma/terraform-module-aws-ecs/tree/main/examples/ecs_capacity_provider)
- [Cluster](https://github.com/janduursma/terraform-module-aws-ecs/tree/main/examples/ecs_cluster)
- [Cluster capacity providers](https://github.com/janduursma/terraform-module-aws-ecs/tree/main/examples/ecs_cluster_capacity_provider)
- [Service](https://github.com/janduursma/terraform-module-aws-ecs/tree/main/examples/ecs_service)
- [Tags](https://github.com/janduursma/terraform-module-aws-ecs/tree/main/examples/ecs_tag)
- [Task definition](https://github.com/janduursma/terraform-module-aws-ecs/tree/main/examples/ecs_task_definition)
- [Task set](https://github.com/janduursma/terraform-module-aws-ecs/tree/main/examples/ecs_task_set)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_account_setting_default.this](https://registry.terraform.io/providers/hashicorp/aws/6.18.0/docs/resources/ecs_account_setting_default) | resource |
| [aws_ecs_capacity_provider.this](https://registry.terraform.io/providers/hashicorp/aws/6.18.0/docs/resources/ecs_capacity_provider) | resource |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/6.18.0/docs/resources/ecs_cluster) | resource |
| [aws_ecs_cluster_capacity_providers.this](https://registry.terraform.io/providers/hashicorp/aws/6.18.0/docs/resources/ecs_cluster_capacity_providers) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/6.18.0/docs/resources/ecs_service) | resource |
| [aws_ecs_tag.this](https://registry.terraform.io/providers/hashicorp/aws/6.18.0/docs/resources/ecs_tag) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/6.18.0/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_set.this](https://registry.terraform.io/providers/hashicorp/aws/6.18.0/docs/resources/ecs_task_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecs_account_setting_defaults"></a> [ecs\_account\_setting\_defaults](#input\_ecs\_account\_setting\_defaults) | List of configuration blocks to create AWS account setting defaults for ECS. | `any` | `[]` | no |
| <a name="input_ecs_capacity_providers"></a> [ecs\_capacity\_providers](#input\_ecs\_capacity\_providers) | List of configuration blocks to create ECS capacity providers. | `any` | `[]` | no |
| <a name="input_ecs_cluster"></a> [ecs\_cluster](#input\_ecs\_cluster) | Configuration block to create an ECS cluster. | `any` | `{}` | no |
| <a name="input_ecs_cluster_capacity_providers"></a> [ecs\_cluster\_capacity\_providers](#input\_ecs\_cluster\_capacity\_providers) | Configuration block to manage the capacity providers of an ECS cluster. | `any` | `{}` | no |
| <a name="input_ecs_services"></a> [ecs\_services](#input\_ecs\_services) | List of configuration blocks to create ECS services. | `any` | `[]` | no |
| <a name="input_ecs_tags"></a> [ecs\_tags](#input\_ecs\_tags) | List of configuration blocks to manage individual ECS resource tags. | `any` | `[]` | no |
| <a name="input_ecs_task_definition"></a> [ecs\_task\_definition](#input\_ecs\_task\_definition) | Configuration block to create a task definition. | `any` | `{}` | no |
| <a name="input_ecs_task_sets"></a> [ecs\_task\_sets](#input\_ecs\_task\_sets) | List of configuration blocks to create ECS task sets. | `any` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
