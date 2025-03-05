# Se um RDS existente for passado, usaremos ele. Caso contrário, criaremos um novo.
data "aws_db_instance" "existing_rds" {
  count = var.rds_instance_id != "" ? 1 : 0
  db_instance_identifier = var.rds_instance_id
}

resource "aws_db_instance" "wordpress_rds" {
  count                   = var.rds_instance_id == "" ? 1 : 0
  allocated_storage       = var.allocated_storage
  engine                  = "mysql"
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  publicly_accessible     = false
  skip_final_snapshot     = true
  vpc_security_group_ids  = [var.rds_sg_id]
  db_subnet_group_name    = var.db_subnet_group_name

  tags = {
    Name = "${var.project_name}-rds"
  }
}

# Definir a instância do RDS que será usada (nova ou existente)
locals {
  rds_instance_id = var.rds_instance_id != "" ? var.rds_instance_id : aws_db_instance.wordpress_rds[0].id
}
