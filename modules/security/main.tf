# Security Group do Load Balancer (ALB) - Usa existente se fornecido
data "aws_security_group" "existing_alb_sg" {
  count = var.alb_sg_id != "" ? 1 : 0
  id    = var.alb_sg_id
}

resource "aws_security_group" "alb_sg" {
  count  = var.alb_sg_id == "" ? 1 : 0
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite tráfego HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite tráfego HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permite saída para qualquer destino"
  }

  tags = {
    Name = "${var.project_name}-alb-sg"
  }
}

locals {
  alb_sg_id = var.alb_sg_id != "" ? var.alb_sg_id : aws_security_group.alb_sg[0].id
}

# Security Group do ECS - Usa existente se fornecido
data "aws_security_group" "existing_ecs_sg" {
  count = var.ecs_sg_id != "" ? 1 : 0
  id    = var.ecs_sg_id
}

