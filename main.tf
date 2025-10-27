resource "aws_ecs_account_setting_default" "this" {
  count = length(var.ecs_account_setting_defaults)

  name  = var.ecs_account_setting_defaults[count.index]["name"]
  value = var.ecs_account_setting_defaults[count.index]["value"]
}

resource "aws_ecs_capacity_provider" "this" {
  count = length(var.ecs_capacity_providers)

  cluster = try(var.ecs_capacity_providers[count.index]["cluster"], null)
  name    = var.ecs_capacity_providers[count.index]["name"]
  region  = try(var.ecs_capacity_providers[count.index]["region"], null)
  tags    = merge(try(var.tags, {}), try(var.ecs_capacity_providers[count.index]["tags"], {}))

  dynamic "auto_scaling_group_provider" {
    for_each = contains(keys(var.ecs_capacity_providers[count.index]), "auto_scaling_group_provider") ? [var.ecs_capacity_providers[count.index]["auto_scaling_group_provider"]] : []

    content {
      auto_scaling_group_arn         = auto_scaling_group_provider.value["auto_scaling_group_arn"]
      managed_draining               = try(auto_scaling_group_provider.value["managed_draining"], null)
      managed_termination_protection = try(auto_scaling_group_provider.value["managed_termination_protection"], null)

      dynamic "managed_scaling" {
        for_each = contains(keys(auto_scaling_group_provider.value), "managed_scaling") ? [auto_scaling_group_provider.value["managed_scaling"]] : []

        content {
          instance_warmup_period    = try(managed_scaling.value["instance_warmup_period"], null)
          maximum_scaling_step_size = try(managed_scaling.value["maximum_scaling_step_size"], null)
          minimum_scaling_step_size = try(managed_scaling.value["minimum_scaling_step_size"], null)
          status                    = try(managed_scaling.value["status"], null)
          target_capacity           = try(managed_scaling.value["target_capacity"], null)
        }
      }
    }
  }

  dynamic "managed_instances_provider" {
    for_each = contains(keys(var.ecs_capacity_providers[count.index]), "managed_instances_provider") ? [var.ecs_capacity_providers[count.index]["managed_instances_provider"]] : []

    content {
      infrastructure_role_arn = managed_instances_provider.value["infrastructure_role_arn"]
      propagate_tags          = try(managed_instances_provider.value["propagate_tags"], null)

      instance_launch_template {
        ec2_instance_profile_arn = managed_instances_provider.value["instance_launch_template"]["ec2_instance_profile_arn"]
        monitoring               = try(managed_instances_provider.value["instance_launch_template"]["monitoring"], null)

        network_configuration {
          subnets         = managed_instances_provider.value["instance_launch_template"]["network_configuration"]["subnets"]
          security_groups = try(managed_instances_provider.value["instance_launch_template"]["network_configuration"]["security_groups"], null)
        }

        dynamic "instance_requirements" {
          for_each = length(keys(try(managed_instances_provider.value["instance_launch_template"]["instance_requirements"], {}))) > 0 ? [managed_instances_provider.value["instance_launch_template"]["instance_requirements"]] : []

          content {
            accelerator_manufacturers                               = try(instance_requirements.value["accelerator_manufacturers"], null)
            accelerator_names                                       = try(instance_requirements.value["accelerator_names"], null)
            accelerator_types                                       = try(instance_requirements.value["accelerator_types"], null)
            allowed_instance_types                                  = try(instance_requirements.value["allowed_instance_types"], null)
            bare_metal                                              = try(instance_requirements.value["bare_metal"], null)
            burstable_performance                                   = try(instance_requirements.value["burstable_performance"], null)
            cpu_manufacturers                                       = try(instance_requirements.value["cpu_manufacturers"], null)
            excluded_instance_types                                 = try(instance_requirements.value["excluded_instance_types"], null)
            instance_generations                                    = try(instance_requirements.value["instance_generations"], null)
            local_storage                                           = try(instance_requirements.value["local_storage"], null)
            local_storage_types                                     = try(instance_requirements.value["local_storage_types"], null)
            max_spot_price_as_percentage_of_optimal_on_demand_price = try(instance_requirements.value["max_spot_price_as_percentage_of_optimal_on_demand_price"], null)
            on_demand_max_price_percentage_over_lowest_price        = try(instance_requirements.value["on_demand_max_price_percentage_over_lowest_price"], null)
            require_hibernate_support                               = try(instance_requirements.value["require_hibernate_support"], null)
            spot_max_price_percentage_over_lowest_price             = try(instance_requirements.value["spot_max_price_percentage_over_lowest_price"], null)

            dynamic "accelerator_count" {
              for_each = length(keys(try(instance_requirements.value["accelerator_count"], {}))) > 0 ? [instance_requirements.value["accelerator_count"]] : []

              content {
                min = try(accelerator_count.value["min"], null)
                max = try(accelerator_count.value["max"], null)
              }
            }

            dynamic "accelerator_total_memory_mib" {
              for_each = length(keys(try(instance_requirements.value["accelerator_total_memory_mib"], {}))) > 0 ? [instance_requirements.value["accelerator_total_memory_mib"]] : []

              content {
                min = try(accelerator_total_memory_mib.value["min"], null)
                max = try(accelerator_total_memory_mib.value["max"], null)
              }
            }

            dynamic "baseline_ebs_bandwidth_mbps" {
              for_each = length(keys(try(instance_requirements.value["baseline_ebs_bandwidth_mbps"], {}))) > 0 ? [instance_requirements.value["baseline_ebs_bandwidth_mbps"]] : []

              content {
                min = try(baseline_ebs_bandwidth_mbps.value["min"], null)
                max = try(baseline_ebs_bandwidth_mbps.value["max"], null)
              }
            }

            dynamic "memory_gib_per_vcpu" {
              for_each = length(keys(try(instance_requirements.value["memory_gib_per_vcpu"], {}))) > 0 ? [instance_requirements.value["memory_gib_per_vcpu"]] : []

              content {
                min = try(memory_gib_per_vcpu.value["min"], null)
                max = try(memory_gib_per_vcpu.value["max"], null)
              }
            }

            dynamic "network_bandwidth_gbps" {
              for_each = length(keys(try(instance_requirements.value["network_bandwidth_gbps"], {}))) > 0 ? [instance_requirements.value["network_bandwidth_gbps"]] : []

              content {
                min = try(network_bandwidth_gbps.value["min"], null)
                max = try(network_bandwidth_gbps.value["max"], null)
              }
            }

            dynamic "network_interface_count" {
              for_each = length(keys(try(instance_requirements.value["network_interface_count"], {}))) > 0 ? [instance_requirements.value["network_interface_count"]] : []

              content {
                min = try(network_interface_count.value["min"], null)
                max = try(network_interface_count.value["max"], null)
              }
            }

            dynamic "total_local_storage_gb" {
              for_each = length(keys(try(instance_requirements.value["total_local_storage_gb"], {}))) > 0 ? [instance_requirements.value["total_local_storage_gb"]] : []

              content {
                min = try(total_local_storage_gb.value["min"], null)
                max = try(total_local_storage_gb.value["max"], null)
              }
            }

            memory_mib {
              min = instance_requirements.value["memory_mib"]["min"]
              max = instance_requirements.value["memory_mib"]["max"]
            }

            vcpu_count {
              min = instance_requirements.value["vcpu_count"]["min"]
              max = instance_requirements.value["vcpu_count"]["max"]
            }
          }
        }

        dynamic "storage_configuration" {
          for_each = length(keys(try(managed_instances_provider.value["instance_launch_template"]["storage_configuration"], {}))) > 0 ? [managed_instances_provider.value["instance_launch_template"]["storage_configuration"]] : []

          content {
            storage_size_gib = storage_configuration.value["storage_size_gib"]
          }
        }
      }
    }
  }
}

resource "aws_ecs_cluster" "this" {
  count = length(keys(var.ecs_cluster)) > 0 ? 1 : 0

  name   = var.ecs_cluster["name"]
  region = try(var.ecs_cluster["region"], null)
  tags   = merge(try(var.tags, {}), try(var.ecs_cluster["tags"], {}))

  dynamic "configuration" {
    for_each = length(keys(try(var.ecs_cluster["configuration"], {}))) > 0 ? [var.ecs_cluster["configuration"]] : []

    content {
      dynamic "execute_command_configuration" {
        for_each = length(keys(try(configuration.value["execute_command_configuration"], {}))) > 0 ? [configuration.value["execute_command_configuration"]] : []

        content {
          kms_key_id = try(execute_command_configuration.value["kms_key_id"], null)
          logging    = try(execute_command_configuration.value["logging"], null)

          dynamic "log_configuration" {
            for_each = length(keys(try(execute_command_configuration.value["log_configuration"], {}))) > 0 ? [execute_command_configuration.value["log_configuration"]] : []

            content {
              cloud_watch_encryption_enabled = try(log_configuration.value["cloud_watch_encryption_enabled"], null)
              cloud_watch_log_group_name     = try(log_configuration.value["cloud_watch_log_group_name"], null)
              s3_bucket_name                 = try(log_configuration.value["s3_bucket_name"], null)
              s3_bucket_encryption_enabled   = try(log_configuration.value["s3_bucket_encryption_enabled"], null)
              s3_key_prefix                  = try(log_configuration.value["s3_key_prefix"], null)
            }
          }
        }
      }

      dynamic "managed_storage_configuration" {
        for_each = length(keys(try(configuration.value["managed_storage_configuration"], {}))) > 0 ? [configuration.value["managed_storage_configuration"]] : []

        content {
          fargate_ephemeral_storage_kms_key_id = try(managed_storage_configuration.value["fargate_ephemeral_storage_kms_key_id"], null)
          kms_key_id                           = try(managed_storage_configuration.value["kms_key_id"], null)
        }
      }
    }
  }

  dynamic "service_connect_defaults" {
    for_each = length(keys(try(var.ecs_cluster["service_connect_defaults"], {}))) > 0 ? [var.ecs_cluster["service_connect_defaults"]] : []

    content {
      namespace = service_connect_defaults.value["namespace"]
    }
  }

  dynamic "setting" {
    for_each = length(keys(try(var.ecs_cluster["setting"], {}))) > 0 ? [var.ecs_cluster["setting"]] : []

    content {
      name  = setting.value["name"]
      value = setting.value["value"]
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  count = length(keys(var.ecs_cluster_capacity_providers)) > 0 ? 1 : 0

  capacity_providers = try(var.ecs_cluster_capacity_providers["capacity_providers"], null)
  cluster_name       = var.ecs_cluster_capacity_providers["cluster_name"]
  region             = try(var.ecs_cluster_capacity_providers["region"], null)

  dynamic "default_capacity_provider_strategy" {
    for_each = try(var.ecs_cluster_capacity_providers["default_capacity_provider_strategies"], [])

    content {
      base              = try(default_capacity_provider_strategy.value["base"], null)
      capacity_provider = default_capacity_provider_strategy.value["capacity_provider"]
      weight            = try(default_capacity_provider_strategy.value["weight"], null)
    }
  }
}

resource "aws_ecs_service" "this" {
  count = length(var.ecs_services)

  availability_zone_rebalancing      = try(var.ecs_services[count.index]["availability_zone_rebalancing"], null)
  cluster                            = try(var.ecs_services[count.index]["cluster"], null)
  deployment_maximum_percent         = try(var.ecs_services[count.index]["deployment_maximum_percent"], null)
  deployment_minimum_healthy_percent = try(var.ecs_services[count.index]["deployment_minimum_healthy_percent"], null)
  desired_count                      = try(var.ecs_services[count.index]["desired_count"], null)
  enable_ecs_managed_tags            = try(var.ecs_services[count.index]["enable_ecs_managed_tags"], null)
  enable_execute_command             = try(var.ecs_services[count.index]["enable_execute_command"], null)
  force_delete                       = try(var.ecs_services[count.index]["force_delete"], null)
  force_new_deployment               = try(var.ecs_services[count.index]["force_new_deployment"], null)
  health_check_grace_period_seconds  = try(var.ecs_services[count.index]["health_check_grace_period_seconds"], null)
  iam_role                           = try(var.ecs_services[count.index]["iam_role"], null)
  launch_type                        = try(var.ecs_services[count.index]["launch_type"], null)
  name                               = try(var.ecs_services[count.index]["name"], null)
  platform_version                   = try(var.ecs_services[count.index]["platform_version"], null)
  propagate_tags                     = try(var.ecs_services[count.index]["propagate_tags"], null)
  scheduling_strategy                = try(var.ecs_services[count.index]["scheduling_strategy"], null)
  sigint_rollback                    = try(var.ecs_services[count.index]["sigint_rollback"], null)
  tags                               = merge(try(var.tags, {}), try(var.ecs_services[count.index]["tags"], {}))
  task_definition                    = try(var.ecs_services[count.index]["task_definition"], null)
  triggers                           = try(var.ecs_services[count.index]["triggers"], {})
  wait_for_steady_state              = try(var.ecs_services[count.index]["wait_for_steady_state"], null)

  dynamic "alarms" {
    for_each = try(var.ecs_services[count.index]["alarms"], [])

    content {
      alarm_names = alarms.value["alarm_names"]
      enable      = alarms.value["enable"]
      rollback    = alarms.value["rollback"]
    }
  }

  dynamic "capacity_provider_strategy" {
    for_each = try(var.ecs_services[count.index]["capacity_provider_strategies"], [])

    content {
      base              = try(capacity_provider_strategy.value["base"], null)
      capacity_provider = capacity_provider_strategy.value["capacity_provider"]
      weight            = try(capacity_provider_strategy.value["weight"], null)
    }
  }

  dynamic "deployment_circuit_breaker" {
    for_each = length(keys(try(var.ecs_services[count.index]["deployment_circuit_breaker"], {}))) > 0 ? [var.ecs_services[count.index]["deployment_circuit_breaker"]] : []

    content {
      enable   = deployment_circuit_breaker.value["enable"]
      rollback = deployment_circuit_breaker.value["rollback"]
    }
  }

  dynamic "deployment_configuration" {
    for_each = length(keys(try(var.ecs_services[count.index]["deployment_configuration"], {}))) > 0 ? [var.ecs_services[count.index]["deployment_configuration"]] : []

    content {
      bake_time_in_minutes = try(deployment_configuration.value["bake_time_in_minutes"], null)
      strategy             = try(deployment_configuration.value["strategy"], null)

      dynamic "lifecycle_hook" {
        for_each = try(deployment_configuration.value["lifecycle_hooks"], [])

        content {
          hook_details     = try(lifecycle_hook.value["hook_details"], null)
          hook_target_arn  = lifecycle_hook.value["hook_target_arn"]
          lifecycle_stages = lifecycle_hook.value["lifecycle_stages"]
          role_arn         = lifecycle_hook.value["role_arn"]
        }
      }
    }
  }

  dynamic "deployment_controller" {
    for_each = length(keys(try(var.ecs_services[count.index]["deployment_controller"], {}))) > 0 ? [var.ecs_services[count.index]["deployment_controller"]] : []

    content {
      type = try(deployment_controller.value["type"], null)
    }
  }

  dynamic "load_balancer" {
    for_each = try(var.ecs_services[count.index]["load_balancers"], [])

    content {
      container_name   = load_balancer.value["container_name"]
      container_port   = load_balancer.value["container_port"]
      elb_name         = try(load_balancer.value["elb_name"], null)
      target_group_arn = try(load_balancer.value["target_group_arn"], null)

      dynamic "advanced_configuration" {
        for_each = length(keys(try(load_balancer.value["advanced_configuration"], {}))) > 0 ? [load_balancer.value["advanced_configuration"]] : []

        content {
          alternate_target_group_arn = advanced_configuration.value["alternate_target_group_arn"]
          production_listener_rule   = advanced_configuration.value["production_listener_rule"]
          role_arn                   = advanced_configuration.value["role_arn"]
          test_listener_rule         = try(advanced_configuration.value["test_listener_rule"], null)
        }
      }
    }
  }

  dynamic "network_configuration" {
    for_each = length(keys(try(var.ecs_services[count.index]["network_configuration"], {}))) > 0 ? [var.ecs_services[count.index]["network_configuration"]] : []

    content {
      assign_public_ip = try(network_configuration.value["assign_public_ip"], null)
      security_groups  = try(network_configuration.value["security_groups"], null)
      subnets          = try(network_configuration.value["subnets"], null)
    }
  }

  dynamic "ordered_placement_strategy" {
    for_each = try(var.ecs_services[count.index]["ordered_placement_strategies"], [])

    content {
      field = try(ordered_placement_strategy.value["field"], null)
      type  = ordered_placement_strategy.value["type"]
    }
  }

  dynamic "placement_constraints" {
    for_each = try(var.ecs_services[count.index]["placement_constraints"], [])

    content {
      expression = try(placement_constraints.value["expression"], null)
      type       = placement_constraints.value["type"]
    }
  }

  dynamic "service_connect_configuration" {
    for_each = length(keys(try(var.ecs_services[count.index]["service_connect_configuration"], {}))) > 0 ? [var.ecs_services[count.index]["service_connect_configuration"]] : []

    content {
      enabled   = service_connect_configuration.value["enabled"]
      namespace = try(service_connect_configuration.value["namespace"], null)

      dynamic "log_configuration" {
        for_each = length(keys(try(service_connect_configuration.value["log_configuration"], {}))) > 0 ? [service_connect_configuration.value["log_configuration"]] : []

        content {
          log_driver = log_configuration.value["log_driver"]
          options    = try(log_configuration.value["options"], null)

          dynamic "secret_option" {
            for_each = try(log_configuration.value["secret_options"], [])

            content {
              name       = secret_option.value["name"]
              value_from = secret_option.value["value_from"]
            }
          }
        }
      }

      dynamic "service" {
        for_each = try(service_connect_configuration.value["services"], [])

        content {
          discovery_name        = try(service.value["discovery_name"], null)
          ingress_port_override = try(service.value["ingress_port_override"], null)
          port_name             = service.value["port_name"]

          dynamic "client_alias" {
            for_each = try(service.value["client_aliases"], [])

            content {
              dns_name = try(client_alias.value["dns_name"], null)
              port     = client_alias.value["port"]

              dynamic "test_traffic_rules" {
                for_each = length(keys(try(client_alias.value["test_traffic_rules"], {}))) > 0 ? [client_alias.value["test_traffic_rules"]] : []

                content {
                  dynamic "header" {
                    for_each = length(keys(try(test_traffic_rules.value["header"], {}))) > 0 ? [test_traffic_rules.value["header"]] : []

                    content {
                      name = header.value["name"]

                      value {
                        exact = header.value["value"]["exact"]
                      }
                    }
                  }
                }
              }
            }
          }

          dynamic "timeout" {
            for_each = length(keys(try(service.value["timeout"], {}))) > 0 ? [service.value["timeout"]] : []

            content {
              idle_timeout_seconds        = try(timeout.value["idle_timeout_seconds"], null)
              per_request_timeout_seconds = try(timeout.value["per_request_timeout_seconds"], null)
            }
          }

          dynamic "tls" {
            for_each = length(keys(try(service.value["tls"], {}))) > 0 ? [service.value["tls"]] : []

            content {
              kms_key  = try(tls.value["kms_key"], null)
              role_arn = try(tls.value["role_arn"], null)

              issuer_cert_authority {
                aws_pca_authority_arn = try(tls.value["issuer_cert_authority"]["aws_pca_authority_arn"], null)
              }
            }
          }
        }
      }
    }
  }

  dynamic "service_registries" {
    for_each = length(keys(try(var.ecs_services[count.index]["service_registries"], {}))) > 0 ? [var.ecs_services[count.index]["service_registries"]] : []

    content {
      container_name = try(service_registries.value["container_name"], null)
      container_port = try(service_registries.value["container_port"], null)
      port           = try(service_registries.value["port"], null)
      registry_arn   = service_registries.value["registry_arn"]
    }
  }

  dynamic "volume_configuration" {
    for_each = try(var.ecs_services[count.index]["volume_configurations"], [])

    content {
      name = volume_configuration.value["name"]

      managed_ebs_volume {
        encrypted                  = try(volume_configuration.value["managed_ebs_volume"]["encrypted"], null)
        file_system_type           = try(volume_configuration.value["managed_ebs_volume"]["file_system_type"], null)
        iops                       = try(volume_configuration.value["managed_ebs_volume"]["iops"], null)
        kms_key_id                 = try(volume_configuration.value["managed_ebs_volume"]["kms_key_id"], null)
        role_arn                   = volume_configuration.value["managed_ebs_volume"]["role_arn"]
        size_in_gb                 = try(volume_configuration.value["managed_ebs_volume"]["size_in_gb"], null)
        snapshot_id                = try(volume_configuration.value["managed_ebs_volume"]["snapshot_id"], null)
        throughput                 = try(volume_configuration.value["managed_ebs_volume"]["throughput"], null)
        volume_initialization_rate = try(volume_configuration.value["managed_ebs_volume"]["volume_initialization_rate"], null)
        volume_type                = try(volume_configuration.value["managed_ebs_volume"]["volume_type"], null)

        dynamic "tag_specifications" {
          for_each = length(keys(try(volume_configuration.value["managed_ebs_volume"]["tag_specifications"], {}))) > 0 ? [volume_configuration.value["managed_ebs_volume"]["tag_specifications"]] : []

          content {
            propagate_tags = try(tag_specifications.value["propagate_tags"], null)
            resource_type  = tag_specifications.value["resource_type"]
            tags           = merge(try(var.tags, {}), try(tag_specifications.value["tags"], {}))
          }
        }
      }
    }
  }

  dynamic "vpc_lattice_configurations" {
    for_each = length(keys(try(var.ecs_services[count.index]["vpc_lattice_configurations"], {}))) > 0 ? [var.ecs_services[count.index]["vpc_lattice_configurations"]] : []

    content {
      port_name        = vpc_lattice_configurations.value["port_name"]
      role_arn         = vpc_lattice_configurations.value["role_arn"]
      target_group_arn = vpc_lattice_configurations.value["target_group_arn"]
    }
  }

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_ecs_tag" "this" {
  count = length(var.ecs_tags)

  key          = var.ecs_tags[count.index]["key"]
  region       = try(var.ecs_tags[count.index]["region"], null)
  resource_arn = var.ecs_tags[count.index]["resource_arn"]
  value        = var.ecs_tags[count.index]["value"]
}

resource "aws_ecs_task_definition" "this" {
  count = length(keys(var.ecs_task_definition)) > 0 ? 1 : 0

  container_definitions    = var.ecs_task_definition["container_definitions"]
  cpu                      = try(var.ecs_task_definition["cpu"], null)
  enable_fault_injection   = try(var.ecs_task_definition["enable_fault_injection"], null)
  execution_role_arn       = try(var.ecs_task_definition["execution_role_arn"], null)
  family                   = var.ecs_task_definition["family"]
  ipc_mode                 = try(var.ecs_task_definition["ipc_mode"], null)
  memory                   = try(var.ecs_task_definition["memory"], null)
  network_mode             = try(var.ecs_task_definition["network_mode"], null)
  pid_mode                 = try(var.ecs_task_definition["pid_mode"], null)
  region                   = try(var.ecs_task_definition["region"], null)
  requires_compatibilities = try(var.ecs_task_definition["requires_compatibilities"], null)
  skip_destroy             = try(var.ecs_task_definition["skip_destroy"], null)
  tags                     = merge(try(var.tags, {}), try(var.ecs_task_definition["tags"], {}))
  task_role_arn            = try(var.ecs_task_definition["task_role_arn"], null)
  track_latest             = try(var.ecs_task_definition["track_latest"], null)

  dynamic "ephemeral_storage" {
    for_each = length(keys(try(var.ecs_task_definition["ephemeral_storage"], {}))) > 0 ? [var.ecs_task_definition["ephemeral_storage"]] : []

    content {
      size_in_gib = ephemeral_storage.value["size_in_gb"]
    }
  }

  dynamic "placement_constraints" {
    for_each = try(var.ecs_task_definition["placement_constraints"], [])

    content {
      expression = try(placement_constraints.value["expression"], null)
      type       = placement_constraints.value["type"]
    }
  }

  dynamic "proxy_configuration" {
    for_each = length(keys(try(var.ecs_task_definition["proxy_configuration"], {}))) > 0 ? [var.ecs_task_definition["proxy_configuration"]] : []

    content {
      container_name = proxy_configuration.value["container_name"]
      properties     = proxy_configuration.value["properties"]
      type           = try(proxy_configuration.value["type"], null)
    }
  }

  dynamic "runtime_platform" {
    for_each = length(keys(try(var.ecs_task_definition["runtime_platform"], {}))) > 0 ? [var.ecs_task_definition["runtime_platform"]] : []

    content {
      cpu_architecture        = try(runtime_platform.value["cpu_architecture"], null)
      operating_system_family = try(runtime_platform.value["operating_system_family"], null)
    }
  }

  dynamic "volume" {
    for_each = try(var.ecs_task_definition["volumes"], [])

    content {
      configure_at_launch = try(volume.value["configure_at_launch"], null)
      host_path           = try(volume.value["host_path"], null)
      name                = volume.value["name"]

      dynamic "docker_volume_configuration" {
        for_each = length(keys(try(volume.value["docker_volume_configuration"], {}))) > 0 ? [volume.value["docker_volume_configuration"]] : []

        content {
          autoprovision = try(docker_volume_configuration.value["autoprovision"], null)
          driver_opts   = try(docker_volume_configuration.value["driver_opts"], null)
          driver        = try(docker_volume_configuration.value["driver"], null)
          labels        = try(docker_volume_configuration.value["labels"], null)
          scope         = try(docker_volume_configuration.value["scope"], null)
        }
      }

      dynamic "efs_volume_configuration" {
        for_each = length(keys(try(volume.value["efs_volume_configuration"], {}))) > 0 ? [volume.value["efs_volume_configuration"]] : []

        content {
          file_system_id          = efs_volume_configuration.value["file_system_id"]
          root_directory          = try(efs_volume_configuration.value["root_directory"], null)
          transit_encryption      = try(efs_volume_configuration.value["transit_encryption"], null)
          transit_encryption_port = try(efs_volume_configuration.value["transit_encryption_port"], null)

          dynamic "authorization_config" {
            for_each = length(keys(try(efs_volume_configuration.value["authorization_config"], {}))) > 0 ? [efs_volume_configuration.value["authorization_config"]] : []

            content {
              access_point_id = try(authorization_config.value["access_point_id"], null)
              iam             = try(authorization_config.value["iam"], null)
            }
          }
        }
      }

      dynamic "fsx_windows_file_server_volume_configuration" {
        for_each = length(keys(try(volume.value["fsx_windows_file_server_volume_configuration"], {}))) > 0 ? [volume.value["fsx_windows_file_server_volume_configuration"]] : []

        content {
          file_system_id = fsx_windows_file_server_volume_configuration.value["file_system_id"]
          root_directory = fsx_windows_file_server_volume_configuration.value["root_directory"]

          authorization_config {
            credentials_parameter = fsx_windows_file_server_volume_configuration.value["authorization_config"]["credentials_parameter"]
            domain                = fsx_windows_file_server_volume_configuration.value["authorization_config"]["domain"]
          }
        }
      }
    }
  }
}

resource "aws_ecs_task_set" "this" {
  count = length(var.ecs_task_sets)

  cluster                   = var.ecs_task_sets[count.index]["cluster"]
  external_id               = try(var.ecs_task_sets[count.index]["external_id"], null)
  force_delete              = try(var.ecs_task_sets[count.index]["force_delete"], null)
  launch_type               = try(var.ecs_task_sets[count.index]["launch_type"], null)
  platform_version          = try(var.ecs_task_sets[count.index]["platform_version"], null)
  region                    = try(var.ecs_task_sets[count.index]["region"], null)
  service                   = var.ecs_task_sets[count.index]["service"]
  tags                      = merge(try(var.tags, {}), try(var.ecs_task_sets[count.index]["tags"], {}))
  task_definition           = var.ecs_task_sets[count.index]["task_definition"]
  wait_until_stable         = try(var.ecs_task_sets[count.index]["wait_until_stable"], null)
  wait_until_stable_timeout = try(var.ecs_task_sets[count.index]["wait_until_stable_timeout"], null)

  dynamic "capacity_provider_strategy" {
    for_each = try(var.ecs_task_sets[count.index]["capacity_provider_strategies"], [])

    content {
      base              = try(capacity_provider_strategy.value["base"], null)
      capacity_provider = capacity_provider_strategy.value["capacity_provider"]
      weight            = capacity_provider_strategy.value["weight"]
    }
  }

  dynamic "load_balancer" {
    for_each = length(keys(try(var.ecs_task_sets[count.index]["load_balancer"], {}))) > 0 ? [var.ecs_task_sets[count.index]["load_balancer"]] : []

    content {
      container_name     = load_balancer.value["container_name"]
      container_port     = try(load_balancer.value["container_port"], null)
      load_balancer_name = try(load_balancer.value["load_balancer_name"], null)
      target_group_arn   = try(load_balancer.value["target_group_arn"], null)
    }
  }

  dynamic "network_configuration" {
    for_each = length(keys(try(var.ecs_task_sets[count.index]["network_configuration"], {}))) > 0 ? [var.ecs_task_sets[count.index]["network_configuration"]] : []

    content {
      assign_public_ip = try(network_configuration.value["assign_public_ip"], null)
      security_groups  = try(network_configuration.value["security_groups"], null)
      subnets          = network_configuration.value["subnets"]
    }
  }

  dynamic "scale" {
    for_each = length(keys(try(var.ecs_task_sets[count.index]["scale"], {}))) > 0 ? [var.ecs_task_sets[count.index]["scale"]] : []

    content {
      unit  = try(scale.value["unit"], null)
      value = try(scale.value["value"], null)
    }
  }

  dynamic "service_registries" {
    for_each = length(keys(try(var.ecs_task_sets[count.index]["service_registries"], {}))) > 0 ? [var.ecs_task_sets[count.index]["service_registries"]] : []

    content {
      container_name = try(service_registries.value["container_name"], null)
      container_port = try(service_registries.value["container_port"], null)
      port           = try(service_registries.value["port"], null)
      registry_arn   = service_registries.value["registry_arn"]
    }
  }
}
