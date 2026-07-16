resource "aws_autoscaling_group" "orion_auto_scaling_group" {
  name                      = var.environment
  min_size                  = var.min_size
  max_size                  = var.max_size
  health_check_grace_period = var.aws_asg_health_check_grace_period
  force_delete              = true
  availability_zones        = var.aws_asg_availability_zones
}
