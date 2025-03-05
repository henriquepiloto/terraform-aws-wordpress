# Se um ID de VPC for passado, utilizamos ele. Caso contrário, criamos uma nova VPC.
data "aws_vpc" "existing_vpc" {
  count = var.vpc_id != "" ? 1 : 0
  id    = var.vpc_id
}

resource "aws_vpc" "wordpress_vpc" {
  count                = var.vpc_id == "" ? 1 : 0
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Definindo a VPC a ser usada (nova ou existente)
locals {
  vpc_id = var.vpc_id != "" ? var.vpc_id : aws_vpc.wordpress_vpc[0].id
}

# Subnets Públicas (Usa existentes ou cria novas)
data "aws_subnet" "existing_public_subnets" {
  count = length(var.public_subnet_ids) > 0 ? length(var.public_subnet_ids) : 0
  id    = var.public_subnet_ids[count.index]
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_ids) == 0 ? length(var.public_subnet_cidrs) : 0
  vpc_id           = local.vpc_id
  cidr_block       = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.project_name}-public-${count.index + 1}"
  }
}

# Subnets Privadas (Usa existentes ou cria novas)
data "aws_subnet" "existing_private_subnets" {
  count = length(var.private_subnet_ids) > 0 ? length(var.private_subnet_ids) : 0
  id    = var.private_subnet_ids[count.index]
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_ids) == 0 ? length(var.private_subnet_cidrs) : 0
  vpc_id           = local.vpc_id
  cidr_block       = var.private_subnet_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.project_name}-private-${count.index + 1}"
  }
}
