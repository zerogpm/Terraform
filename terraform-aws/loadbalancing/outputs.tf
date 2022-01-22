#--- loadbalancing/outputs.tf ---
output "lb_target_group_arn" {
  value = aws_lb_target_group.bu-tg.arn
}

output "lb_endpoint" {
  value = aws_lb.bu-alb.dns_name
}