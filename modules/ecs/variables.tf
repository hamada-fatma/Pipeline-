# Network Variables
variable "subnets" {
  description = "List of subnets for the ECS service and Load Balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
###############
variable "ecs_task_execution_role_name" {
  description = "IAM role name for ECS task execution"
  type        = string
}

variable "ecs_task_role_name" {
  description = "IAM role name for ECS tasks"
  type        = string
}

variable "execution_role_policy_arn" {
  description = "ARN of the managed policy for the ECS task execution role"
  type        = string
}

variable "load_balancer_name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "target_groups" {
  description = "List of Target Groups for the Load Balancer"
  type        = list(object({
    name     = string
    port     = number
    protocol = string
  }))
}

variable "listener_ports" {
  description = "List of listener ports for the Load Balancer"
  type        = list(number)
}
