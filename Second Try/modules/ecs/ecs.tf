resource "aws_ecs_cluster" "this" {
  name = "white-hart"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = "my-app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name      = "my-app-container"
      image     = "amazonlinux"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "ENV_VAR_NAME"
          value = "value"
        }
      ]
    }
  ])

  execution_role_arn = var.execution_role_arn  # Utilisation de la variable
  task_role_arn      = var.task_role_arn       # Utilisation de la variable
}

resource "aws_ecs_service" "this" {
    #depends_on = [modules.loadbalancer]

  name            = "my-app-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }
}
