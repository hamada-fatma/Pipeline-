variable "ecs_task_execution_role_name" {
  description = "Nom du rôle IAM pour l'exécution des tâches ECS"
  type        = string
  default     = "ecsTaskExecutionRole"
}

variable "ecs_task_role_name" {
  description = "Nom du rôle IAM pour les tâches ECS"
  type        = string
  default     = "ecsTaskRole"
}

variable "execution_role_policy_arn" {
  description = "ARN de la politique gérée pour le rôle d'exécution ECS"
  type        = string
  default     = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
