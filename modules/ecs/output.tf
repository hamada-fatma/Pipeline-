output "target_group_arns" {
  value = [for tg in aws_lb_target_group.this : tg.arn]
}

output "load_balancer_sg_id" {
  value = tolist(aws_lb.this.security_groups)[0]
}


output "load_balancer_dns_name" {
  value = aws_lb.this.dns_name
}





