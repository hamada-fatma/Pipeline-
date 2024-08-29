variable "vpc_cidr_block" {
  description = "Le bloc CIDR pour le VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet1_cidr_block" {
  description = "Le bloc CIDR pour le premier sous-réseau"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet2_cidr_block" {
  description = "Le bloc CIDR pour le deuxième sous-réseau"
  type        = string
  default     = "10.0.2.0/24"
}

variable "security_group_name" {
  description = "Le nom du groupe de sécurité ECS"
  type        = string
  default     = "ecs_security_group"
}

variable "ingress_port" {
  description = "Le port d'ingress pour le groupe de sécurité"
  type        = number
  default     = 3000
}

variable "egress_port" {
  description = "Le port d'egress pour le groupe de sécurité"
  type        = number
  default     = 0
}
