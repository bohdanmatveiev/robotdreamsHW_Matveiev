module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "project-vpc"
}

module "subnets" {
  source       = "./modules/subnets"
  vpc_id       = module.vpc.vpc_id
  public_cidr  = "10.0.1.0/24"
  private_cidr = "10.0.2.0/24"
}

module "ec2_public" {
  source        = "./modules/ec2"
  subnet_id     = module.subnets.public_subnet_id
  ami           = var.ami
  instance_type = var.instance_type
  name          = "public-server"
}

module "ec2_private" {
  source        = "./modules/ec2"
  subnet_id     = module.subnets.private_subnet_id
  ami           = var.ami
  instance_type = var.instance_type
  name          = "private-server"
}
