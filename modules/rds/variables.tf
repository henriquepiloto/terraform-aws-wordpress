variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "rds_instance_id" {
  description = "ID de uma instância RDS existente (deixe vazio para criar uma nova)"
  type        = string
  default     = ""
}

variable "allocated_storage" {
  description = "Tamanho do armazenamento do RDS (em GB)"
  type        = number
  default     = 20
}

variable "engine_version" {
  description = "Versão do MySQL a ser usada"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "Tipo da instância do RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
  default     = "wordpress_db"
}

variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}

variable "rds_sg_id" {
  description = "ID do Security Group do RDS"
  type        = string
}

variable "db_subnet_group_name" {
  description = "Nome do grupo de subnets do RDS"
  type        = string
}
