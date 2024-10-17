## VPC et sous-réseaux
#vpc_cidr_block     = "10.1.0.0/16"
#subnet1_cidr_block = "10.1.1.0/24"
#subnet2_cidr_block = "10.1.2.0/24"

## Groupe de sécurité
#security_group_name = "web-traffic-sg"
#ingress_port        = 8080
#egress_port         = 0

## IAM Variables
#ecs_task_execution_role_name = "ecs-app-execution-role"
#ecs_task_role_name           = "ecs-app-task-role"
#execution_role_policy_arn    = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

## Load Balancer
#load_balancer_name = "web-lb"

## Target Groups et Listeners
## target_groups = [
# #  {
#  #   name     = "web-traffic-tg"
#   #  port     = 80
#    # protocol = "HTTP"
#   #}
# #]
  #target_groups = [
   # {
    #  name     = "service1-tg"
     # port     = 8080
      #protocol = "HTTP"
    #},
    #{
     # name     = "service2-tg"
      #port     = 9090
     # protocol = "HTTP"
    #}
  #]
 #listener_ports = [8080, 9090]
##listener_ports = [80]

# #Informations réseau
#subnets = ["subnet-01f32a794d5f61d6c", "subnet-002b66f8da426d7bb"]  # Mettez ici vos IDs de sous-réseaux si connus
#vpc_id  = "vpc-010fafea6c2fe15a3"  # VPC ID

# Network Module Variables
vpc_cidr_block     = "10.1.0.0/16"
subnet1_cidr_block = "10.1.1.0/24"
subnet2_cidr_block = "10.1.2.0/24"

security_group_name = "web-traffic-sg"
ingress_ports       = [8080, 9090, 80]
egress_port         = 0

# ECS Module Variables
aws_account_id               = "767397685517"
ecs_task_execution_role_name = "ecs-app-execution-role"
ecs_task_role_name           = "ecs-app-task-role"
execution_role_policy_arn    = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

load_balancer_name = "web-lb"

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

listener_ports = [80, 8080, 9090]
