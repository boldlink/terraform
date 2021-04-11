
// IAM Role
resource "aws_iam_instance_profile" "main" {
  name = "${var.name}_ecs_service_iam_role"
  path = var.iam_policy_path
  role = aws_iam_role.main.name
}

resource "aws_iam_role" "main" {
  description        = "${var.name} ECS Service IAM Role"
  name               = "${var.name}_ecs_service_iam_role"
  path               = var.iam_policy_path
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_policy" "main" {
  name        = "${var.name}_iam_pol"
  description = "${var.name} ECS Service IAM policy"
  path        = var.iam_policy_path
  policy      = var.policy
}

resource "aws_iam_policy_attachment" "main" {
  name       = var.name
  roles      = [aws_iam_role.main.name]
  policy_arn = aws_iam_policy.main.arn
}

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

// ECS Task Defenition
resource "aws_ecs_task_definition" "main" {
  family                   = "${var.name}_task"
  task_role_arn            = aws_iam_role.main.arn
  execution_role_arn       = aws_iam_role.main.arn
  network_mode             = var.network_mode
  requires_compatibilities = [var.launch_type]
  cpu                      = var.cpu
  memory                   = var.memory
  volume {
    name      = var.volume_name
    host_path = var.volume_path
  }
  container_definitions = var.container_definitions
  depends_on            = [aws_iam_role.main]
}

