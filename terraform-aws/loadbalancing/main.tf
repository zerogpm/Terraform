#--- loadbalancing/main.tf ---

resource "aws_lb" "bu-alb" {
  name            = "bu-application-loadbalancer"
  subnets         = var.public_subnets
  security_groups = [var.public_sg]
  idle_timeout    = 400
}

resource "aws_lb_target_group" "bu-tg" {
  name     = "bu-lb-tg-${substr(uuid(), 0, 5)}"
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = var.lb_healthy_threshold
    unhealthy_threshold = var.lb_unhealthy_threshold
    timeout             = var.lb_timeout
    interval            = var.lb_interval
  }
}

resource "aws_lb_listener" "bu-lb-listener" {
  load_balancer_arn = aws_lb.bu-alb.arn
  port              = var.listener_port
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bu-tg.arn
  }
}