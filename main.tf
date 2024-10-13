module "network" {
  source = "./modules/network"


  vpc_cidr_block     = var.vpc_cidr_block
  subnet1_cidr_block = var.subnet1_cidr_block
  subnet2_cidr_block = var.subnet2_cidr_block

  security_group_name = var.security_group_name
 # ingress_ports       = var.ingress_ports
  ingress_ports   = var.ingress_ports
  egress_port         = var.egress_port
}

# Module ECS
module "ecs" {
  source = "./modules/ecs"

  aws_account_id = var.aws_account_id  # Référence à la variable

  # Réseau
  ingress_ports = var.ingress_ports
  subnets         = module.network.subnet_ids
  vpc_id          = module.network.vpc_id
  #ingress_ports   = var.ingress_ports

  # IAM
  ecs_task_execution_role_name = var.ecs_task_execution_role_name
  ecs_task_role_name           = var.ecs_task_role_name
  execution_role_policy_arn    = var.execution_role_policy_arn

  # Load Balancer
  load_balancer_name = var.load_balancer_name

  # Target Groups et Listeners
  target_groups   = var.target_groups
  listener_ports  = var.listener_ports
  microservices   = var.microservices

}