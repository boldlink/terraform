
resource "aws_ecs_service" "main" {
  name            = var.name
  cluster         = var.cluster
  task_definition = var.task_definition
  desired_count   = var.desired_count
  launch_type     = var.launch_type
  iam_role        = var.iam_role_arn
  # depends_on      = ["aws_iam_role_policy.foo"]
  # placement_strategy {
  #   type  = "binpack"
  #   field = "cpu"
  # }
  load_balancer {
    elb_name          = var.lb
    target_group_name = var.target_group_name
    container_name    = var.name
    container_port    = var.port
  }
  #   placement_constraints {
  #     type       = "memberOf"
  #     expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  #   }
}