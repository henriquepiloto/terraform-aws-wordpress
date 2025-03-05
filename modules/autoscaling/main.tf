# Se um Auto Scaling de Storage do RDS existente for passado, usamos ele. Caso contrário, criamos um novo.
data "aws_rds_cluster" "existing_rds" {
  count        = var.rds_cluster_id != "" ? 1 : 0
  cluster_identifier = var.rds_cluster_id
}

resource "aws_rds_cluster" "rds_scaling" {
  count                      = var.rds_cluster_id == "" ? 1 : 0
  cluster_identifier         = "${var.project_name}-rds-cluster"
  storage_encrypted          = true
  apply_immediately          = true
  database_name              = var.db_name
  master_username            = var.db_user
  master_password            = var.db_password
  engine                     = "aurora-mysql"
  engine_version             = var.rds_engine_version
  backup_retention_period    = 7
  preferred_backup_window    = "07:00-09:00"
  db_subnet_group_name       = var.db_subnet_group_name
  vpc_security_group_ids     = [var.rds_sg_id]
  deletion_protection        = false
  scaling_configuration {
    auto_pause               = true
    min_capacity             = var.rds_min_capacity
    max_capacity             = var.rds_max_capacity
    seconds_until_auto_pause = 600
  }
}

locals {
  rds_cluster_id = var.rds_cluster_id != "" ? var.rds_cluster_id : aws_rds_cluster.rds_scaling[0].id
}
