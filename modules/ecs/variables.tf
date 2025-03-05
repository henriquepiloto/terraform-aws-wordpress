variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "ecs_cluster_id" {
  description = "ID de um Cluster ECS existente (deixe vazio para criar um novo)"
  type        = string
  default     = ""
}

variable "task_definition_arn" {
  description = "ARN de uma Task Definition existente (deixe vazio para criar uma nova)"
  type        = string
  default     = ""
}

variable "ecs_service_name" {
  description = "Nome de um Service ECS existente (deixe vazio para criar um novo)"
  type        = string
  default     = ""
}

variable "task_cpu" {
  description = "Quantidade de CPU para a Task Definition"
  type        = string
  default     = "256"
}

variable "task_memory" {
  description = "Quantidade de memória para a Task Definition"
  type        = string
  default     = "512"
}

variable "execution_role_arn" {
  description = "ARN da IAM Role de execução do ECS"
  type        = string
}

variable "task_role_arn" {
  description = "ARN da IAM Role da Task Definition"
  type        = string
}

variable "container_image" {
  description = "Imagem do contêiner para o WordPress"
  type        = string
  default     = "wordpress:latest"
}

variable "db_host" {
  description = "Endpoint do banco de dados"
  type        = string
}

variable "db_user" {
  description = "Usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
}

variable "desired_count" {
  description = "Número de instâncias desejadas para o serviço ECS"
  type        = number
  default     = 1
}

variable "private_subnets" {
  description = "Lista de subnets privadas para rodar o ECS"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "ID do Security Group do ECS"
  type        = string
}

variable "alb_target_group_arn" {
  description = "ARN do Target Group do Load Balancer"
  type        = string
}

variable "aws_region" {
  description = "Região da AWS"
  type        = string
}
