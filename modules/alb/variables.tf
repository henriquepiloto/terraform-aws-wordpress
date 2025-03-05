variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "public_subnets" {
  description = "Lista de subnets públicas"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "ID do Security Group do Load Balancer"
  type        = string
}

variable "alb_id" {
  description = "ID do Load Balancer existente (deixe vazio para criar um novo)"
  type        = string
  default     = ""
}
