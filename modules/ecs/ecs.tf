# ECS Cluster
resource "aws_ecs_cluster" "this" {
  name = "app-deployment-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

# IAM Role for ECS Task Execution
resource "aws_iam_role" "execution" {
  name = var.ecs_task_execution_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = [var.execution_role_policy_arn]
}

# IAM Role for ECS Task
resource "aws_iam_role" "task" {
  name = var.ecs_task_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

# Attach Managed Policy to Execution Role
resource "aws_iam_role_policy_attachment" "execution_policy" {
  role       = aws_iam_role.execution.name
  policy_arn = var.execution_role_policy_arn
}


resource "aws_lb" "this" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id] # Utilise le groupe de sécurité du LB
  subnets            = var.subnets
}

resource "aws_lb_listener" "http" {
  for_each          = aws_lb_target_group.this
  load_balancer_arn = aws_lb.this.arn
  port              = each.value.port
  protocol          = each.value.protocol

  default_action {
    type             = "forward"
    target_group_arn = each.value.arn
  }
}
