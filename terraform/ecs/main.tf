resource "aws_ecs_cluster" "azp_agent" {
  name = "azuredevops"
  tags = {
    Name = "azuredevops"
  }
}

resource "aws_cloudwatch_log_group" "cloud_azuredevops_agent" {
  name              = "/ecs/cloud-azuredevops-agent"
  retention_in_days = 1
}

resource "aws_ecs_task_definition" "cloud_azuredevops_agent" {
  family                   = "cloud-azuredevops-agent"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "2048"
  memory                   = "4096"
  network_mode             = "awsvpc"
  execution_role_arn       = data.aws_iam_role.ecs_role.arn
  task_role_arn            = data.aws_iam_role.ecs_role.arn
  container_definitions = jsonencode([
    {
      name      = "cloud-azuredevops-agent",
      image     = "${data.aws_ecr_image.azpagent.image_uri}",
      essential = true,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80,
          protocol      = "tcp"
        }
      ],
      environment = [
        {
          name  = "AZP_URL",
          value = "VAR_AZP_URL_VALUE"
        },
        {
          name  = "AZP_TOKEN",
          value = "VAR_AZP_TOKEN_VALUE"
        },
        {
          name  = "AZP_POOL",
          value = "cloud-varejo-agent"
        },
        {
          name  = "AZP_AGENT_NAME",
          value = "Docker Agent - Linux"
        },
        {
          name  = "PORT"
          value = "80"
        },
        {
          name  = "LOG_LEVEL"
          value = "DEBUG"
        }
      ],
      mountPoints = [],
      volumesFrom = [],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "${aws_cloudwatch_log_group.cloud_azuredevops_agent.name}",
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix = "ecs"
        }
      },
      systemControles = []
    }
  ])
}

resource "aws_ecs_service" "cloud_azuredevops_agent" {
  name                               = "cloud-azuredevops-agent"
  cluster                            = aws_ecs_cluster.azp_agent.id
  task_definition                    = aws_ecs_task_definition.cloud_azuredevops_agent.arn
  desired_count                      = 0
  launch_type                        = "FARGATE"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  deployment_controller {
    type = "ECS"
  }
  network_configuration {
    subnets = [
      data.aws_subnet.public_subnet_01.id,
      data.aws_subnet.public_subnet_02.id
    ]
    security_groups  = [data.aws_security_group.devops_security_group.id]
    assign_public_ip = true
  }
  triggers = {
    redeployment = plantimestamp()
  }
  lifecycle {
    create_before_destroy = true
  }
}
