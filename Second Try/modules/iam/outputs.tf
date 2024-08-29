output "ecs_task_execution_role_arn" {
  value = aws_iam_role.this.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.task_role.arn
}