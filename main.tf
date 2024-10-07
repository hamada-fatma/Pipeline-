module "network" {
  source = "./modules/network"


  vpc_cidr_block     = "10.1.0.0/16"
  subnet1_cidr_block = "10.1.1.0/24"
  subnet2_cidr_block = "10.1.2.0/24"

  security_group_name = "web-traffic-sg"
  #ingress_port        = 8080
  ingress_ports       = [80, 9090]
  egress_port         = 0
}

# ECS Module
module "ecs" {
  source = "./modules/ecs"

  aws_account_id = "654654419152"  # Ajout de l'argument requis
  # Network Inputs
  subnets         = module.network.subnet_ids
  vpc_id          = module.network.vpc_id

  # IAM Variables
  ecs_task_execution_role_name = "ecs-app-execution-role"
  ecs_task_role_name           = "ecs-app-task-role"
  execution_role_policy_arn    = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

  # Load Balancer Variables
  load_balancer_name = "web-lb"

  # Ajout des nouvelles variables pour gérer plusieurs Target Groups et Listeners
  target_groups = [
    {
      name     = "service1-tg"
      port     = 80
      protocol = "HTTP"
    },
    {
      name     = "service2-tg"
      port     = 9090
      protocol = "HTTP"
    }
  ]


  listener_ports = [80,9090]

  
}
