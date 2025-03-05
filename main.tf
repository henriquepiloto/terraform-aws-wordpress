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
