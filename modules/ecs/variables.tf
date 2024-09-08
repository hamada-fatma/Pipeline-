variable "execution_role_arn" {
  description = "ARN du rôle d'exécution pour ECS Task"
  type        = string
}

variable "task_role_arn" {
  description = "ARN du rôle pour ECS Task"
  type        = string
}

# Network Variables
variable "subnets" {
  description = "List of subnets for the ECS service and Load Balancer"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security groups for the ECS service and Load Balancer"
  type        = list(string)
}

# variable "vpc_id" {
#   description = "VPC ID"
#   type        = string
# }

# IAM Variables
variable "ecs_task_execution_role_name" {
  description = "IAM role name for ECS Task Execution"
  type        = string
  default     = "ecsTaskExecutionRole"
}

variable "ecs_task_role_name" {
  description = "IAM role name for ECS Task"
  type        = string
  default     = "ecsTaskRole"
}

variable "execution_role_policy_arn" {
  description = "ARN of the managed policy for ECS Task Execution role"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Load Balancer Variables
variable "load_balancer_name" {
  description = "Name of the Load Balancer"
  type        = string
}

# variable "listener_port" {
#   description = "Listener port for the Load Balancer"
#   type        = number
# }

# variable "target_group_name" {
#   description = "Name of the Target Group"
#   type        = string
# }

# variable "target_group_port" {
#   description = "Port for the Target Group"
#   type        = number
# }


variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}


#########

variable "target_groups" {
  description = "Liste des Target Groups avec le nom, le port et le protocole"
  type = list(object({
    name     = string
    port     = number
    protocol = string
  }))
  default = [
    {
      name     = "web-traffic-tg"
      port     = 80
      protocol = "HTTP"
    }
  ]
}

variable "listener_ports" {
  description = "Liste des ports pour les listeners"
  type        = list(number)
  default     = [80]
}
