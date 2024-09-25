 module "network" {
  source = "./modules/network"

  vpc_cidr_block     = "10.1.0.0/16"
  subnet1_cidr_block = "10.1.1.0/24"
  subnet2_cidr_block = "10.1.2.0/24"

  security_group_name = "web-traffic-sg"
  #ingress_port        = 8080
  ingress_ports  = [80, 8080, 9090] 
  egress_port         = 0
}

# ECS Module
module "ecs" {
  source = "./modules/ecs"

  # Network Inputs
  aws_account_id = "339712918863"  # Ajout de l'argument requis
  subnets         = module.network.subnet_ids
  vpc_id          = module.network.vpc_id

  # IAM Variables
  ecs_task_execution_role_name = "ecs-app-execution-role"
  ecs_task_role_name           = "ecs-app-task-role"
  execution_role_policy_arn    = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

  # Load Balancer Variables
  load_balancer_name = "web-lb"

  # Ajout des nouvelles variables pour gérer plusieurs Target Groups et Listeners
  # target_groups = [
  #   {
  #     name     = "web-traffic-tg"
  #     port     = 80
  #     protocol = "HTTP"
  #   }
   
  # ]
  # Ajout des nouveaux groupes de cibles pour les deux microservices
  target_groups = [
    {
      name     = "service1-tg"
      port     = 8080
      protocol = "HTTP"
    },
    {
      name     = "service2-tg"
      port     = 9090
      protocol = "HTTP"
    }
  ]


  #listener_ports = [80]
  listener_ports = [8080, 9090]

  
}

# # Module réseau
# module "network" {
#   source = "./modules/network"

#   vpc_cidr_block     = var.vpc_cidr_block
#   subnet1_cidr_block = var.subnet1_cidr_block
#   subnet2_cidr_block = var.subnet2_cidr_block

#   security_group_name = var.security_group_name
#   ingress_port        = var.ingress_port
#   egress_port         = var.egress_port
# }

# # Module ECS
# module "ecs" {
#   source = "./modules/ecs"

#   # Variables réseau
#   subnets = var.subnets
#   vpc_id  = var.vpc_id

#   # Variables IAM
#   ecs_task_execution_role_name = var.ecs_task_execution_role_name
#   ecs_task_role_name           = var.ecs_task_role_name
#   execution_role_policy_arn    = var.execution_role_policy_arn

#   # Variables Load Balancer
#   load_balancer_name = var.load_balancer_name

#   # Target Groups et Listeners
#   target_groups   = var.target_groups
#   listener_ports  = var.listener_ports
# }
