# Network Module Variables
variable "vpc_cidr_block" {
  type = string
}

variable "subnet1_cidr_block" {
  type = string
}

variable "subnet2_cidr_block" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "ingress_ports" {
  type = list(number)
}

variable "egress_port" {
  type = number
}

# ECS Module Variables
variable "aws_account_id" {
  type = string
}

variable "ecs_task_execution_role_name" {
  type = string
}

variable "ecs_task_role_name" {
  type = string
}

variable "execution_role_policy_arn" {
  type = string
}

variable "load_balancer_name" {
  type = string
}

variable "target_groups" {
  type = list(object({
    name     = string
    port     = number
    protocol = string
  }))
}

variable "listener_ports" {
  type = list(number)
}
variable "microservices" {
  description = "Liste des microservices avec les informations nécessaires pour créer les définitions de tâches et services ECS"
  type = list(object({
    app_name       = string
    container_port = number
    host_port      = number
    cpu            = number
    memory         = number
  }))}
