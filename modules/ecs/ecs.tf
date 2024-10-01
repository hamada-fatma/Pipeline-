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
resource "aws_lb_target_group" "this" {
  #for_each    = { for service in var.microservices : service.app_name => service }
  for_each          = { for idx, service in var.microservices : service.app_name => service }
  name        = "${each.value.app_name}-tg"
  port        = each.value.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}
resource "aws_ecs_task_definition" "this" {
  for_each                = { for idx, service in var.microservices : service.app_name => service }  
  family                  = "${each.value.app_name}-app"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = each.value.cpu
  memory                  = each.value.memory

  container_definitions = templatefile("${path.module}/task_definition.json.tpl", {
    container_name = each.value.app_name
    aws_account_id = var.aws_account_id
    aws_region     = var.aws_region
    app_name       = each.value.app_name
    cpu            = each.value.cpu
    memory         = each.value.memory
    container_port = each.value.container_port
    host_port      = each.value.host_port
  })

  execution_role_arn = aws_iam_role.execution.arn
  task_role_arn      = aws_iam_role.task.arn
}
resource "aws_ecs_service" "this" {
  for_each          = { for idx, service in var.microservices : service.app_name => service }
  name              = "${each.value.app_name}-ecs-service"
  cluster           = aws_ecs_cluster.this.id
  task_definition   = aws_ecs_task_definition.this[each.key].arn
  launch_type       = "FARGATE"
  desired_count     = 1

  network_configuration {
    subnets         = var.subnets
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this[each.key].arn
    container_name   = each.value.app_name
    container_port   = each.value.container_port
  }

  depends_on = [aws_lb_listener.http]
}

############
resource "aws_security_group" "lb_sg" {
  name   = "lb_security_group"
  vpc_id = var.vpc_id  # Utilise la variable vpc_id


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Permet l'accès public sur le port 80
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "ecs_sg" {
  name   = "ecs_security_group"
  vpc_id = var.vpc_id  # Utilisation de la variable vpc_id
  # Crée une règle d'Ingress pour chaque port dans la liste ingress_ports
  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Autorise l'accès public
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_ecr_repository" "services" {
  for_each = { for microservice in var.microservices : microservice.app_name => microservice }

  name = each.key
}
