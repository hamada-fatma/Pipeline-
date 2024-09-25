variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet1_cidr_block" {
  description = "The CIDR block for the first subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet2_cidr_block" {
  description = "The CIDR block for the second subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "security_group_name" {
  description = "The name of the ECS security group"
  type        = string
  default     = "ecs_security_group"
}

variable "egress_port" {
  description = "The egress port for the security group"
  type        = number
  default     = 0
}

# # Variable pour les ports d'ingress
variable "ingress_ports" {
  description = "Liste des ports autorisés pour l'accès entrant"
  type        = list(number)
  default     = [80, 8080, 9090] # Ajoutez les ports nécessaires ici
}
