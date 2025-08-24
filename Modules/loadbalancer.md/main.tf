resource "aws_lb" "load_balancer" {
  name               = var.lb_name
  internal           = var.internal_lb
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = var.lb_security_group
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "target_group" {
  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
    health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200-399"
  }

}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
