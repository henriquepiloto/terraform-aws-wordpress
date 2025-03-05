output "vpc_id" {
  description = "ID da VPC usada"
  value       = local.vpc_id
}

output "public_subnets" {
  description = "Lista de subnets públicas"
  value       = length(var.public_subnet_ids) > 0 ? var.public_subnet_ids : aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  description = "Lista de subnets privadas"
  value       = length(var.private_subnet_ids) > 0 ? var.private_subnet_ids : aws_subnet.private_subnets[*].id
}
