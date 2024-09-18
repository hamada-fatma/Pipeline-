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

#################

resource "aws_lb_target_group" "this" {
  for_each    = { for tg in var.target_groups : tg.name => tg }
  name        = each.value.name
  port        = each.value.port
  protocol    = each.value.protocol
  vpc_id      = var.vpc_id
  target_type = "ip"
}
################



# ECS Task Definition
resource "aws_ecs_task_definition" "this" {
  family                   = "my-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "nginx-container"
      image     = "nginx:latest" # Use the Nginx image from Docker Hub
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80  # Nginx default port
          hostPort      = 80  # Map to host port 80
          protocol      = "tcp"
        }
      ]
    }
  ])

  #execution_role_arn = var.execution_role_arn
  execution_role_arn = aws_iam_role.execution.arn
  #task_role_arn      = var.task_role_arn
  task_role_arn      = aws_iam_role.task.arn
}


resource "aws_ecs_service" "this" {
  name            = "my-nginx-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = var.subnets
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  dynamic "load_balancer" {
    for_each = aws_lb_target_group.this
    content {
      target_group_arn = load_balancer.value.arn
      container_name   = "nginx-container"#variable et kif tayetelha fi west el main et nehot valeur fi west tfvars 
      container_port   = 80 # Remplace par une valeur dynamique si nécessaire
    }
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

  # Autoriser uniquement le Load Balancer à accéder au cluster ECS
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_sg.id] # Autorise uniquement le groupe de sécurité du Load Balancer
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
####

######################################