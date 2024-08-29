output "load_balancer_arn" {
  value = aws_lb.this.arn
}

output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}



output "load_balancer_sg_id" {
  value = tolist(aws_lb.this.security_groups)[0]
}
