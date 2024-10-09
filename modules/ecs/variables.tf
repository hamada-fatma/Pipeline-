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
variable "aws_region" {
  description = "Région AWS"
  type        = string
  default     = "us-east-1"  # Facultatif si vous avez une région par défaut
}
variable "aws_account_id" {
  description = "ID du compte AWS"
  type        = string
}


# Variable pour les ports d'ingress
variable "ingress_ports" {
  description = "Liste des ports autorisés pour l'accès entrant"
  type        = list(number)
  default     = [80, 8080, 9090] # Ajoutez les ports nécessaires ici
}

#########
variable "microservices" {
  description = "Liste des microservices avec les informations nécessaires pour créer les définitions de tâches et services ECS"
  type = list(object({
    app_name       = string
    container_port = number
    host_port      = number
    cpu            = number
    memory         = number
  }))
  default = [
    {
      app_name       = "service1"
      container_port = 80
      host_port      = 80
      cpu            = 256
      memory         = 512
    },
 {
      app_name       = "service1"
      container_port = 80
      host_port      = 8080
      cpu            = 256
      memory         = 512
    }
  ]
}
