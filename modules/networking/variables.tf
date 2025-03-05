variable "project_name" {
  description = "Nome do projeto"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC existente (se vazio, cria uma nova)"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "CIDR da VPC (usado se uma nova for criada)"
  type        = string
}

variable "public_subnet_ids" {
  description = "Lista de IDs de subnets públicas existentes (se vazio, cria novas)"
  type        = list(string)
  default     = []
}

variable "public_subnet_cidrs" {
  description = "Lista de CIDRs para as subnets públicas (usado se criar novas)"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subnets privadas existentes (se vazio, cria novas)"
  type        = list(string)
  default     = []
}

variable "private_subnet_cidrs" {
  description = "Lista de CIDRs para as subnets privadas (usado se criar novas)"
  type        = list(string)
}

variable "availability_zones" {
  description = "Lista de zonas de disponibilidade"
  type        = list(string)
}
