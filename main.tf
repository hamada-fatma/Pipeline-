# # Network module
# # Network Module
module "network" {
  source = "./modules/network"
 # vpc_id = aws_vpc.this.id  # Passe l'ID du VPC au module network
  vpc_id = module.network.vpc_id


  vpc_cidr_block     = "10.1.0.0/16"
  subnet1_cidr_block = "10.1.1.0/24"
  subnet2_cidr_block = "10.1.2.0/24"

  security_group_name = "web-traffic-sg"
  ingress_port        = 8080
  egress_port         = 0
}

# # ECS Module
# module "ecs" {
#   source = "./modules/ecs"

#   # Network Inputs
#   subnets         = module.network.subnet_ids
#   security_groups = [module.ecs.lb_sg_id]
#   vpc_id          = module.network.vpc_id


#   # IAM Variables
#   ecs_task_execution_role_name = "ecs-app-execution-role"
#   ecs_task_role_name           = "ecs-app-task-role"
#   execution_role_policy_arn    = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

#   # Load Balancer Variables
#   load_balancer_name = "web-lb"
#   listener_port      = 80
#   target_group_name  = "web-traffic-tg"
#   target_group_port  = 3000

#   # Utilisation des sorties du module ECS
#   execution_role_arn = module.ecs.ecs_task_execution_role_arn
#   task_role_arn      = module.ecs.ecs_task_role_arn
# }
##################
# ECS Module
module "ecs" {
  source = "./modules/ecs"

  # Network Inputs
  subnets         = module.network.subnet_ids
  security_groups = [module.ecs.lb_sg_id]
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
      name     = "web-traffic-tg"
      port     = 80
      protocol = "HTTP"
    }
    # {
    #   name     = "api-traffic-tg"
    #   port     = 8080
    #   protocol = "HTTP"
    # }
  ]

  listener_ports = [80]

  # Utilisation des sorties du module ECS
  execution_role_arn = module.ecs.ecs_task_execution_role_arn
  task_role_arn      = module.ecs.ecs_task_role_arn
}
