variable "execution_role_arn" {
  description = "ARN du rôle d'exécution pour ECS Task"
  type        = string
}

variable "task_role_arn" {
  description = "ARN du rôle pour ECS Task"
  type        = string
}

variable "subnets" {
  description = "Liste des sous-réseaux pour le service ECS"
  type        = list(string)
}

variable "security_groups" {
  description = "Liste des groupes de sécurité pour le service ECS"
  type        = list(string)
}



