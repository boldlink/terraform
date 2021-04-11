

# CloudWatch Log Group 

resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/ecs/${var.cluster}/apps/${var.tag_env}/${var.name}"

  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

# ECS Service

resource "aws_ecs_service" "main" {
  name            = "${var.name}_service"
  cluster         = var.cluster
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  network_configuration {
    subnets         = var.subnets
    security_groups = var.security_groups
  }

  depends_on = [aws_ecs_task_definition.main]
}

# ECS Task Definition
resource "aws_ecs_task_definition" "main" {
  family                   = "${var.name}_task"
  task_role_arn            = var.task_role_arn
  execution_role_arn       = var.task_role_arn
  network_mode             = var.network_mode
  requires_compatibilities = [var.launch_type]
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = var.container_definitions

  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

