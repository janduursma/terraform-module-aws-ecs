variable "ecs_account_setting_defaults" {
  description = "List of configuration blocks to create AWS account setting defaults for ECS."
  type        = any
  default     = []
}

variable "ecs_capacity_providers" {
  description = "List of configuration blocks to create ECS capacity providers."
  type        = any
  default     = []
}

variable "ecs_cluster" {
  description = "Configuration block to create an ECS cluster."
  type        = any
  default     = {}
}

variable "ecs_cluster_capacity_providers" {
  description = "Configuration block to manage the capacity providers of an ECS cluster."
  type        = any
  default     = {}
}

variable "ecs_services" {
  description = "List of configuration blocks to create ECS services."
  type        = any
  default     = []
}

variable "ecs_tags" {
  description = "List of configuration blocks to manage individual ECS resource tags."
  type        = any
  default     = []
}

variable "ecs_task_definition" {
  description = "Configuration block to create a task definition."
  type        = any
  default     = {}
}

variable "ecs_task_sets" {
  description = "List of configuration blocks to create ECS task sets."
  type        = any
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
