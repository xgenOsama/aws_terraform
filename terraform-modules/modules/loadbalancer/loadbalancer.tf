# create the target group
resource "aws_lb_target_group" "backend_target_group" {
  name     = "${var.name_tag}-${var.environment}-backend-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.my_vpc_id
}

# create the loadbalancer
resource "aws_lb" "lb_public" {
  name               = "${var.name_tag}-${var.environment}-lb-public"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_allow_http_alb_sg_id]
  subnets            = [var.subnet_public1_id,var.subnet_public2_id]

  tags = {
    Name =  "${var.name_tag}-${var.environment}-lb-public"
  }
}

# create the listener
resource "aws_lb_listener" "backend_target_group_lisners" {
  load_balancer_arn = aws_lb.lb_public.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }
}

# attach instances to target groups
resource "aws_lb_target_group_attachment" "backend1_target_group_attachment" {
  target_group_arn = aws_lb_target_group.backend_target_group.arn
  target_id        = var.aws_instance_backend1_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "backend2_target_group_attachment" {
  target_group_arn = aws_lb_target_group.backend_target_group.arn
  target_id        = var.aws_instance_backend2_id
  port             = 80
}