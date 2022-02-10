module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.7.0"
  # insert the 4 required variables here
  name               = "bu-alb"
  load_balancer_type = "application"
  vpc_id             = var.vpc_id
  security_groups    = [var.security_groups]
  subnets            = var.subnets

  #listener
  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  target_groups = [
    # App1 Target Group - TG Index = 0
    {
      name_prefix          = "app1-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      # App1 Target Group - Targets
      targets = {
        my_app1_vm1 = {
          target_id = var.private_ec2_ids[0]
          port      = 80
        },
        my_app1_vm2 = {
          target_id = var.private_ec2_ids[1]
          port      = 80
        }
      }
    }
  ]
}