resource "aws_lb" "orion_load_balancer" {
  name               = "${var.environment}_load_balancer"
  load_balancer_type = var.aws_load_balancer_type

  tags = {
    Environment = "${var.environment}_load_balancer"
  }
}

