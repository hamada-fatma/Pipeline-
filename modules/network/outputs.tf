output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_ids" {
  value = [aws_subnet.this1.id, aws_subnet.this2.id]
}


# output "security_group_id" {
#   value = aws_security_group.this.id
# }

