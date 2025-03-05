module "networking" {
  source = "./modules/networking"

  project_name        = "wordpress"

  # Se a VPC já existir, defina o ID abaixo
  vpc_id             = "vpc-12345678"  # Defina "" para criar uma nova

  # Se a VPC for criada, defina um CIDR
  vpc_cidr           = "10.0.0.0/16"

  # Se subnets públicas já existirem, use os IDs abaixo
  public_subnet_ids  = ["subnet-abc123", "subnet-def456"]  # Deixe [] para criar novas
  private_subnet_ids = ["subnet-xyz789", "subnet-jkl012"]  # Deixe [] para criar novas

  # Se for criar novas subnets, defina os CIDRs abaixo
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

  # Zonas de disponibilidade onde os recursos serão criados
  availability_zones   = ["us-east-1a", "us-east-1b"]
}
module "security" {
  source      = "./modules/security"
  project_name = "wordpress"
  vpc_id      = module.networking.vpc_id
  alb_sg_id   = ""  # Se existir, informe o ID
  ecs_sg_id   = ""  # Se existir, informe o ID
  rds_sg_id   = ""  # Se existir, informe o ID
}

module "alb" {
  source      = "./modules/alb"
  project_name = "wordpress"
  vpc_id      = module.networking.vpc_id
  public_subnets = module.networking.public_subnets
  alb_sg_id   = module.security.alb_sg_id
  alb_id      = ""  # Se existir, informe o ID
}
module "rds" {
  source              = "./modules/rds"
  project_name        = "wordpress"

  # Se existir um RDS, informe o ID. Se não, ele será criado.
  rds_instance_id     = ""  

  allocated_storage   = 20
  engine_version      = "8.0"
  instance_class      = "db.t3.micro"
  db_name             = "wordpress_db"
  db_username         = "admin"
  db_password         = "supersecurepassword"

  rds_sg_id           = module.security.rds_sg_id
  db_subnet_group_name = ""  # Se existir, informe o nome
  private_subnets     = module.networking.private_subnets
}
module "ecs" {
  source              = "./modules/ecs"
  project_name        = "wordpress"

  # Se um cluster ECS já existir, informe o ID. Se não, ele será criado.
  ecs_cluster_id      = ""

  # Se uma Task Definition já existir, informe o ARN.
  task_definition_arn = ""

  # Se um Service ECS já existir, informe o nome.
  ecs_service_name    = ""

  task_cpu            = "256"
  task_memory         = "512"
  execution_role_arn  = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
  task_role_arn       = "arn:aws:iam::123456789012:role/ecsTaskRole"
  container_image     = "wordpress:latest"

  db_host             = module.rds.rds_endpoint
  db_user             = "admin"
  db_password         = "supersecurepassword"
  db_name             = "wordpress_db"

  desired_count       = 2
  private_subnets     = module.networking.private_subnets
  ecs_sg_id           = module.security.ecs_sg_id
  alb_target_group_arn = module.alb.alb_target_group_arn
  aws_region          = "us-east-1"
}
