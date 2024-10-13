# variable "vpc_cidr_block" {
#   description = "The CIDR block for the VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }

# variable "subnet1_cidr_block" {
#   description = "The CIDR block for the first subnet"
#   type        = string
#   default     = "10.0.1.0/24"
# }

# variable "subnet2_cidr_block" {
#   description = "The CIDR block for the second subnet"
#   type        = string
#   default     = "10.0.2.0/24"
# }

# variable "security_group_name" {
#   description = "The name of the ECS security group"
#   type        = string
#   default     = "ecs_security_group"
# }


# variable "egress_port" {
#   description = "The egress port for the security group"
#   type        = number
#   default     = 0
# }

# # # Variable pour les ports d'ingress
# variable "ingress_ports" {
#   description = "Liste des ports autorisés pour l'accès entrant"
#   type        = list(number)
#   default     = [80, 8080, 9090] # Ajoutez les ports nécessaires ici
# }

 variable "subnets" { 
  description = "List of subnets for the ECS service and Load Balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
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
  description = "AWS region"
  type        = string
  default     = "us-east-1"  
}

variable "ingress_ports" {
  description = "Liste des ports d'accès entrants autorisés pour le groupe de sécurité ECS"
  type        = list(number)
}



variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "microservices" {
  description = "List of microservices with necessary information to create ECS task definitions and services"
  type = list(object({
    app_name       = string
    container_port = number
    host_port      = number
    cpu            = number
    memory         = number
  })) 
  }