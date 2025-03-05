output "ecs_cluster_id" {
  description = "ID do Cluster ECS utilizado"
  value       = local.ecs_cluster_id
}

output "task_definition_arn" {
  description = "ARN da Task Definition utilizada"
  value       = local.task_definition_arn
}

output "ecs_service_name" {
  description = "Nome do Service ECS utilizado"
  value       = local.ecs_service_name
}
