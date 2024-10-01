[
  {
    "name": "${container_name}",
    "image": "${aws_account_id}.dkr.ecr.${aws_region}.amazonaws.com/${app_name}:latest",
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "portMappings": [
      {
        "containerPort": ${container_port},
        "hostPort": ${host_port},
        "protocol": "tcp"
      }
    ]
  }
]
