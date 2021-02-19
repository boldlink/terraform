terraform {
  required_version  = "> 0.11.10"
}

// IAM Role
resource "aws_iam_instance_profile" "main" {
  name                        = "${var.name}_ecs_service_iam_role"
  path                        = "${var.iam_policy_path}"
  role                        = "${aws_iam_role.main.name}"
}

resource "aws_iam_role" "main" {
  description                 = "${var.name} ECS Service IAM Role"
  name                        = "${var.name}_ecs_service_iam_role"
  path                        = "${var.iam_policy_path}"
  assume_role_policy          = "${var.assume_role_policy}"
}

resource "aws_iam_policy" "main" {
    name                      = "${var.name}_iam_pol"
    description               = "${var.name} ECS Service IAM policy"
    path                      = "${var.iam_policy_path}"
    policy                    = "${var.policy}"
}

resource "aws_iam_policy_attachment" "main" {
    name                      = "${var.name}"
    roles                     = ["${aws_iam_role.main.name}"]
    policy_arn                = "${aws_iam_policy.main.arn}"
}

resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/ecs/${var.cluster}/apps/${var.tag_env}/${var.name}"
  tags = "${merge(map(
    "Name", "${var.name}",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}

// Security Group
resource "aws_security_group" "main" {
  name                        = "${var.name}-service"
  description                 = "Allow ssh inbound & all outbound traffic"
  vpc_id                      = "${var.vpc_id}"

  ingress {
    from_port                 = "${var.container_port}"
    to_port                   = "${var.container_port}"
    protocol                  = "tcp"
    security_groups           = ["${var.security_groups}"]
  }
  egress {
    from_port                 = 0
    to_port                   = 0
    protocol                  = "-1"
    cidr_blocks               = ["0.0.0.0/0"]
  }
  tags = "${merge(map(
    "Name", "${var.name}-service",
    "Environment", "${var.tag_env}"),
    var.other_tags
  )}"
}

// ECS Service
resource "aws_ecs_service" "main" {
  name            = "${var.name}-service"
  cluster         = "${var.cluster}"
  task_definition = "${aws_ecs_task_definition.main.arn}"
  desired_count   = "${var.desired_count}"
  launch_type     = "${var.launch_type}"
  network_configuration {
    subnets = ["${var.subnets}"]
    assign_public_ip = "${var.assign_public_ip}"
    security_groups = ["${aws_security_group.main.id}"]
  }
  load_balancer {
    target_group_arn = "${var.target_group_arn}"
    container_name = "${var.name}"
    container_port = "${var.container_port}"
  }
  depends_on      = ["aws_ecs_task_definition.main"]
}

// ECS Task Defenition
resource "aws_ecs_task_definition" "main" {
  family = "${var.name}_task"
  task_role_arn = "${aws_iam_role.main.arn}"
  execution_role_arn = "${aws_iam_role.main.arn}"
  network_mode = "${var.network_mode}"
  requires_compatibilities = ["${var.launch_type}"]
  cpu = "${var.cpu}"
  memory = "${var.memory}"
  volume {
    name = "${var.volume_name}"
    host_path = "${var.volume_path}"
  }
  container_definitions = "${var.container_definitions}"
  depends_on = ["aws_iam_role.main"]
}

// Autoscaling Policies Resources
// Bellow are the resources to trigger autoscaling events and report to an email address (default)

resource "aws_appautoscaling_target" "main" {
  max_capacity       = "${var.max_capacity}"
  min_capacity       = "${var.desired_count}"
  resource_id        = "service/${var.cluster}/${aws_ecs_service.main.name}"
  scalable_dimension = "${var.scalable_dimension}"
  service_namespace  = "${var.service_namespace}"
  depends_on = ["aws_ecs_service.main"]
}
