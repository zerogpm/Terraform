#--- loadbalancing/main.tf ---

resource "aws_lb" "bu-alb" {
  name = "bu-application-loadbalancer"
  subnets = var.public_subnets
  security_groups = [var.public_sg]
  idle_timeout = 400
}