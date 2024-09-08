# output "ecs_service_id" {
#   value = aws_ecs_service.this.id
# }

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.execution.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.task.arn
}

# output "load_balancer_arn" {
#   value = aws_lb.this.arn
# }

# output "target_group_arn" {
#   value = aws_lb_target_group.this.arn
# }

output "target_group_arns" {
  value = [for tg in aws_lb_target_group.this : tg.arn]
}

output "load_balancer_sg_id" {
  value = tolist(aws_lb.this.security_groups)[0]
}


output "load_balancer_dns_name" {
  value = aws_lb.this.dns_name
}
output "lb_sg_id" {
  value = aws_security_group.lb_sg.id
}


