# Network Module Variables
aws_account_id = "381492099535"  # ID de ton compte AWS 

# Variables réseau
vpc_cidr_block     = "10.1.0.0/16"
subnet1_cidr_block = "10.1.1.0/24"
subnet2_cidr_block = "10.1.2.0/24"
security_group_name = "web-traffic-sg"
ingress_ports       = [8080, 9090, 80]
egress_port         = 0

# Variables ECS et Load Balancer
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

microservices = [
  {
    app_name       = "service1"
    container_port = 8080
    host_port      = 8080
    cpu            = 256
    memory         = 512
  },
  {
    app_name       = "service2"
    container_port = 9090
    host_port      = 9090
    cpu            = 256
    memory         = 512
  }
]


listener_ports = [80, 8080, 9090]
