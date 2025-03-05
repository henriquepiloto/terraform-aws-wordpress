variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC onde os Security Groups serão criados"
  type        = string
}

variable "alb_sg_id" {
  description = "ID de um Security Group existente para o ALB (deixe vazio para criar)"
  type        = string
  default     = ""
}

variable "ecs_sg_id" {
  description = "ID de um Security Group existente para o ECS (deixe vazio para criar)"
  type        = string
  default     = ""
}

variable "rds_sg_id" {
  description = "ID de um Security Group existente para o RDS (deixe vazio para criar)"
  type        = string
  default     = ""
}
