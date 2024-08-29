variable "load_balancer_name" {
  description = "Nom du Load Balancer"
  type        = string
}

variable "listener_port" {
  description = "Port d'écoute du Load Balancer"
  type        = number
}

variable "target_group_name" {
  description = "Nom du Target Group"
  type        = string
}

variable "target_group_port" {
  description = "Port du Target Group"
  type        = number
}

variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "subnets" {
  description = "Liste des sous-réseaux pour le Load Balancer"
  type        = list(string)
}

variable "security_groups" {
  description = "Groupes de sécurité pour le Load Balancer"
  type        = list(string)
}
