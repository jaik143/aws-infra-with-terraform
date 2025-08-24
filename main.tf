locals {
  nginx_config_content = templatefile("./nginx.tpl", {
    internal_lb_dns = module.load_balancer_internal.load_balancer_dns})
}

module "vpc" {
  source   = "./Modules/vpc.md"
  vpc_cidr =  "10.0.0.0/16"
  igw_name = "project-IGW"
}

module "public_rt" {
  source    = "./Modules/routetable.md"
  vpc_id    = module.vpc.vpc_id
  igw_id    = module.vpc.igw_id
  rt_name   = "Public-RT"
  enable_public_route = true
}

module "subnet_1" {
  source            = "./Modules/subnet.md"
  vpc_id            = module.vpc.vpc_id
  cidr_subnet       = "10.0.0.0/24"
  subnet_name       = "public-1"
  map_public_ip = true
  availability_zone = "us-east-1a"
  route_table_id = module.public_rt.route_table_id
}

module "nat_1" {
  source    = "./Modules/nat.md"
  eip_name       = "EIP1"
  subnet_id = module.subnet_1.subnet_id
  nat_name  = "NAT-1"
}

module "private_rt_1" {
  source  = "./Modules/routetable.md"
  vpc_id  = module.vpc.vpc_id
  nat_id  = module.nat_1.nat_id
  rt_name = "Private-RT-1"
  enable_public_route  = false
  enable_private_route = true
}

module "subnet_2" {
  source            = "./Modules/subnet.md"
  vpc_id            = module.vpc.vpc_id
  cidr_subnet       = "10.0.1.0/24"
  subnet_name       = "private-1"
  availability_zone = "us-east-1a"
  route_table_id             = module.private_rt_1.route_table_id
}

module "subnet_3" {
  source            = "./Modules/subnet.md"
  vpc_id            = module.vpc.vpc_id
  cidr_subnet       = "10.0.2.0/24"
  subnet_name       = "public-2"
  map_public_ip     = true
  availability_zone = "us-east-1b"
  route_table_id    = module.public_rt.route_table_id
}


module "nat_2" {
  source    = "./Modules/nat.md"
  eip_name =   "EIP2"
  subnet_id = module.subnet_3.subnet_id
  nat_name  = "NAT-2"
}

module "private_rt_2" {
  source  = "./Modules/routetable.md"
  vpc_id  = module.vpc.vpc_id
  nat_id  = module.nat_2.nat_id
  rt_name = "Private-RT-2"
  enable_public_route  = false
  enable_private_route = true
}

module "subnet_4" {
  source            = "./Modules/subnet.md"
  vpc_id            = module.vpc.vpc_id
  cidr_subnet       = "10.0.3.0/24"
  subnet_name       = "private-2"
  availability_zone = "us-east-1b"
  route_table_id             = module.private_rt_2.route_table_id
}

module "sec_group" {
  source  = "./Modules/securitygroup.md"
  vpc_id  = module.vpc.vpc_id
  sg_name = "HTTP-SSH"
}

module "load_balancer_internal" {
  source           = "./Modules/loadbalancer.md"
  target_group_name = "Internal-Target-Group"
  vpc_id           = module.vpc.vpc_id
  lb_name          = "Internal-LB"
  lb_security_group     = [module.sec_group.sec_group_id]
  subnet_ids        = [module.subnet_2.subnet_id, module.subnet_4.subnet_id]
  internal_lb      = true
}

module "load_balancer_external" {
  source           = "./Modules/loadbalancer.md"
  target_group_name = "External-Target-Group"
  vpc_id           = module.vpc.vpc_id
  lb_name          = "External-LB"
  lb_security_group     = [module.sec_group.sec_group_id]
  subnet_ids       = [module.subnet_1.subnet_id, module.subnet_3.subnet_id]
  internal_lb      = false
}

module "nginx_1" {
  source            = "./Modules/ec2.md"
  instance_type     = "t2.micro"
  subnet_id         = module.subnet_1.subnet_id
  security_group_id = module.sec_group.sec_group_id
  depends_on = [ module.load_balancer_external ]
  target_group_arn  = module.load_balancer_external.target_group_arn
  instance_name     = "Nginx"
  key_name         = "mykeypair"
  user_data = templatefile("./nginx.sh", {
  nginx_config    = local.nginx_config_content,
  internal_lb_dns = module.load_balancer_internal.load_balancer_dns})
}

module "nginx_2" {
  source            = "./Modules/ec2.md"
  instance_type     = "t2.micro"
  subnet_id         = module.subnet_3.subnet_id
  security_group_id = module.sec_group.sec_group_id
  target_group_arn  = module.load_balancer_external.target_group_arn
  depends_on = [ module.load_balancer_external ]
  instance_name     = "Nginx2"
  key_name         = "mykeypair"
  user_data = templatefile("./nginx.sh", {
  nginx_config    = local.nginx_config_content,
  internal_lb_dns = module.load_balancer_internal.load_balancer_dns})
}

module "be1_apache" {
  source            = "./Modules/ec2.md"
  instance_type     = "t2.micro"
  subnet_id         = module.subnet_2.subnet_id
  security_group_id = module.sec_group.sec_group_id
  depends_on = [ module.load_balancer_internal ]
  instance_name     = "BE-Apache"
  target_group_arn  = module.load_balancer_internal.target_group_arn
  user_data         = file("./apache1.sh")
  key_name         = "mykeypair"
}

module "be2_apache" {
  source            = "./Modules/ec2.md"
  instance_type     = "t2.micro"
  subnet_id         = module.subnet_4.subnet_id
  security_group_id = module.sec_group.sec_group_id
  instance_name     = "BE-Apache2"
  depends_on = [ module.load_balancer_internal ]
  target_group_arn  = module.load_balancer_internal.target_group_arn
  user_data         = file("./apache2.sh")
  key_name         = "mykeypair"
}