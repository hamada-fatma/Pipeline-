# Network module

module "network" {
  source = "./modules/network"


  vpc_cidr_block        = "10.1.0.0/16"
  subnet1_cidr_block    = "10.1.1.0/24"
  subnet2_cidr_block    = "10.1.2.0/24"

  security_group_name   = "custom_security_group"
  ingress_port          = 8080
  egress_port           = 0
}


module "iam" {
  source = "./modules/iam"

  ecs_task_execution_role_name = "customExecutionRoleName"
  ecs_task_role_name           = "customTaskRoleName"
  execution_role_policy_arn    = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}



############
#########
module "loadbalancer" {
  source             = "./modules/loadbalancer"
  load_balancer_name = "my-app-lb"
  listener_port      = 80
  target_group_name  = "my-app-tg"
  target_group_port  = 3000
  vpc_id             = module.network.vpc_id
  subnets            = module.network.subnet_ids
  security_groups    = [module.network.security_group_id]
}

module "ecs" {
  source            = "./modules/ecs"
  execution_role_arn = module.iam.ecs_task_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn
  subnets            = module.network.subnet_ids
  security_groups    = [module.loadbalancer.load_balancer_sg_id]
}