
resource "aws_instance" "main" {
  ami                     = var.ami
  instance_type           = var.instance_type
  iam_instance_profile    = var.iam_instance_profile
  availability_zone       = var.availability_zone
  ebs_optimized           = var.ebs_optimized
  disable_api_termination = var.disable_api_termination
  key_name                = var.key_name
  monitoring              = var.monitoring
  vpc_security_group_ids  = var.vpc_security_group_ids
  source_dest_check       = var.source_dest_check
  user_data               = var.user_data
  subnet_id               = var.subnet_id
  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }
  tags = merge(
    {
      "Name"        = var.name
      "Environment" = var.tag_env
    },
    var.other_tags,
  )
}

