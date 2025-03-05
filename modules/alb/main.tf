# Load Balancer - Usa existente se fornecido
data "aws_lb" "existing_alb" {
  count = var.alb_id != "" ? 1 : 0
  id    = var.alb_id
}

resource "aws_lb" "wordpress_alb" {
  count              = var.alb_id == "" ? 1 : 0
  name               = "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets           = var.public_subnets

  tags = {
    Name = "${var.project_name}-alb"
  }
}

locals {
  alb_id = var.alb_id != "" ? var.alb_id : aws_lb.wordpress_alb[0].id
}
