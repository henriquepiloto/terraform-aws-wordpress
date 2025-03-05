output "alb_sg_id" {
  description = "ID do Security Group do ALB"
  value       = local.alb_sg_id
}

output "ecs_sg_id" {
  description = "ID do Security Group do ECS"
  value       = local.ecs_sg_id
}

output "rds_sg_id" {
  description = "ID do Security Group do RDS"
  value       = local.rds_sg_id
}
