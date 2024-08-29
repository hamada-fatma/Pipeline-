output "ecs_service_id" {
  value = aws_ecs_service.this.id
}

output "execution_role_arn" {
  value = var.execution_role_arn
}

output "task_role_arn" {
  value = var.task_role_arn
}
