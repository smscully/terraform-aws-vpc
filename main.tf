########################################
# Configure AWS Provider
########################################
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

########################################
# Call VPC Module
########################################
module "VPC" {
  source           = "./modules/vpc"
  environment_name = var.environment_name
  cidr_block       = "10.0.0.0/16"
}

########################################
# Call Subnet Module
########################################
module "Subnet_Pub_1" {
  source                  = "./modules/subnet"
  name                    = "Subnet Pub 1"
  environment_name        = var.environment_name
  vpc_id                  = module.VPC.vpc_id
  availability_zone       = "0"
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = true
}

module "Subnet_Pub_2" {
  source                  = "./modules/subnet"
  name                    = "Subnet Pub 2"
  environment_name        = var.environment_name
  vpc_id                  = module.VPC.vpc_id
  availability_zone       = "1"
  cidr_block              = "10.0.11.0/24"
  map_public_ip_on_launch = true
}

module "Subnet_Web_1" {
  source            = "./modules/subnet"
  name              = "Subnet Web 1"
  environment_name  = var.environment_name
  vpc_id            = module.VPC.vpc_id
  availability_zone = "0"
  cidr_block        = "10.0.20.0/24"
}

module "Subnet_Web_2" {
  source            = "./modules/subnet"
  name              = "Subnet Web 2"
  environment_name  = var.environment_name
  vpc_id            = module.VPC.vpc_id
  availability_zone = "1"
  cidr_block        = "10.0.21.0/24"
}

module "Subnet_App_1" {
  source            = "./modules/subnet"
  name              = "Subnet App 1"
  environment_name  = var.environment_name
  vpc_id            = module.VPC.vpc_id
  availability_zone = "0"
  cidr_block        = "10.0.30.0/24"
}

module "Subnet_App_2" {
  source            = "./modules/subnet"
  name              = "Subnet App 2"
  environment_name  = var.environment_name
  vpc_id            = module.VPC.vpc_id
  availability_zone = "1"
  cidr_block        = "10.0.31.0/24"
}

module "Subnet_DB_1" {
  source            = "./modules/subnet"
  name              = "Subnet DB 1"
  environment_name  = var.environment_name
  vpc_id            = module.VPC.vpc_id
  availability_zone = "0"
  cidr_block        = "10.0.40.0/24"
}

module "Subnet_DB_2" {
  source            = "./modules/subnet"
  name              = "Subnet DB 2"
  environment_name  = var.environment_name
  vpc_id            = module.VPC.vpc_id
  availability_zone = "1"
  cidr_block        = "10.0.41.0/24"
}

########################################
# Call NAT Gateway Module
########################################
module "NAT_Gateway_1" {
  source           = "./modules/nat"
  name             = "NAT Gateway 1"
  environment_name = var.environment_name
  subnet_id        = module.Subnet_Pub_1.subnet_id
}

module "NAT_Gateway_2" {
  source           = "./modules/nat"
  name             = "NAT Gateway 2"
  environment_name = var.environment_name
  subnet_id        = module.Subnet_Pub_2.subnet_id
}

########################################
# Call Route Table Module
########################################
module "Subnet_Pub_1_Route_Table" {
  source           = "./modules/rt"
  name             = "Subnet Pub 1 Route Table"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_id        = module.Subnet_Pub_1.subnet_id
}

module "Subnet_Pub_2_Route_Table" {
  source           = "./modules/rt"
  name             = "Subnet Pub 2 Route Table"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_id        = module.Subnet_Pub_2.subnet_id
}

module "Subnet_Web_1_Route_Table" {
  source           = "./modules/rt"
  name             = "Subnet Web 1 Route Table"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_id        = module.Subnet_Web_1.subnet_id
}

module "Subnet_Web_2_Route_Table" {
  source           = "./modules/rt"
  name             = "Subnet Web 2 Route Table"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_id        = module.Subnet_Web_2.subnet_id
}

module "Subnet_App_1_Route_Table" {
  source           = "./modules/rt"
  name             = "Subnet App 1 Route Table"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_id        = module.Subnet_App_1.subnet_id
}

module "Subnet_App_2_Route_Table" {
  source           = "./modules/rt"
  name             = "Subnet App 2 Route Table"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_id        = module.Subnet_App_2.subnet_id
}

module "Subnet_DB_1_Route_Table" {
  source           = "./modules/rt"
  name             = "Subnet DB 1 Route Table"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_id        = module.Subnet_DB_1.subnet_id
}

module "Subnet_DB_2_Route_Table" {
  source           = "./modules/rt"
  name             = "Subnet DB 2 Route Table"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_id        = module.Subnet_DB_2.subnet_id
}

########################################
# Call Route Table Route Module
########################################
module "Subnet_Pub_1_Route_Table_Route" {
  source         = "./modules/rt_route"
  route_table_id = module.Subnet_Pub_1_Route_Table.route_table_id
  gateway_id     = module.VPC.gateway_id
}

module "Subnet_Pub_2_Route_Table_Route" {
  source         = "./modules/rt_route"
  route_table_id = module.Subnet_Pub_2_Route_Table.route_table_id
  gateway_id     = module.VPC.gateway_id
}

module "Subnet_Web_1_Route_Table_Route" {
  source         = "./modules/rt_route"
  route_table_id = module.Subnet_Web_1_Route_Table.route_table_id
  nat_gateway_id = module.NAT_Gateway_1.nat_gateway_id
}

module "Subnet_Web_2_Route_Table_Route" {
  source         = "./modules/rt_route"
  route_table_id = module.Subnet_Web_2_Route_Table.route_table_id
  nat_gateway_id = module.NAT_Gateway_2.nat_gateway_id
}

module "Subnet_App_1_Route_Table_Route" {
  source         = "./modules/rt_route"
  route_table_id = module.Subnet_App_1_Route_Table.route_table_id
  nat_gateway_id = module.NAT_Gateway_1.nat_gateway_id
}

module "Subnet_App_2_Route_Table_Route" {
  source         = "./modules/rt_route"
  route_table_id = module.Subnet_App_2_Route_Table.route_table_id
  nat_gateway_id = module.NAT_Gateway_2.nat_gateway_id
}

########################################
# Call Security Group Module
########################################
module "Security_Group_Pub" {
  source           = "./modules/sg"
  name             = "Security Group Pub"
  environment_name = var.environment_name
  description      = "Security group for public access servers"
  vpc_id           = module.VPC.vpc_id
}

module "Security_Group_Web" {
  source           = "./modules/sg"
  name             = "Security Group Web"
  environment_name = var.environment_name
  description      = "Security group for web servers"
  vpc_id           = module.VPC.vpc_id
}

module "Security_Group_App" {
  source           = "./modules/sg"
  name             = "Security Group App"
  environment_name = var.environment_name
  description      = "Security group for app servers"
  vpc_id           = module.VPC.vpc_id
}

module "Security_Group_DB" {
  source           = "./modules/sg"
  name             = "Security Group DB"
  environment_name = var.environment_name
  description      = "Security group for DB servers"
  vpc_id           = module.VPC.vpc_id
}

########################################
# Call Security Group Rule Module
########################################
module "Ingress_Rule_Pub" {
  source            = "./modules/sg_rule"
  security_group_id = module.Security_Group_Pub.security_group_id
  cidr_ipv4         = "192.168.0.0/16"
  from_port         = "22"
  to_port           = "22"
  ip_protocol       = "tcp"
  ingress           = true
}

module "Egress_Rule_Pub" {
  source                       = "./modules/sg_rule"
  security_group_id            = module.Security_Group_Pub.security_group_id
  referenced_security_group_id = module.Security_Group_Web.security_group_id
  from_port                    = "443"
  to_port                      = "443"
  ip_protocol                  = "tcp"
  egress                       = true
}

module "Ingress_Rule_Web" {
  source                       = "./modules/sg_rule"
  security_group_id            = module.Security_Group_Web.security_group_id
  referenced_security_group_id = module.Security_Group_Pub.security_group_id
  from_port                    = "443"
  to_port                      = "443"
  ip_protocol                  = "tcp"
  ingress                      = true
}

module "Egress_Rule_Web" {
  source                       = "./modules/sg_rule"
  security_group_id            = module.Security_Group_Web.security_group_id
  referenced_security_group_id = module.Security_Group_App.security_group_id
  from_port                    = "443"
  to_port                      = "443"
  ip_protocol                  = "tcp"
  egress                       = true
}

module "Ingress_Rule_App" {
  source                       = "./modules/sg_rule"
  security_group_id            = module.Security_Group_App.security_group_id
  referenced_security_group_id = module.Security_Group_Web.security_group_id
  from_port                    = "443"
  to_port                      = "443"
  ip_protocol                  = "tcp"
  ingress                      = true
}

module "Egress_Rule_App" {
  source                       = "./modules/sg_rule"
  security_group_id            = module.Security_Group_App.security_group_id
  referenced_security_group_id = module.Security_Group_DB.security_group_id
  from_port                    = "3306"
  to_port                      = "3306"
  ip_protocol                  = "tcp"
  egress                       = true
}

module "Ingress_Rule_DB" {
  source                       = "./modules/sg_rule"
  security_group_id            = module.Security_Group_DB.security_group_id
  referenced_security_group_id = module.Security_Group_App.security_group_id
  from_port                    = "3306"
  to_port                      = "3306"
  ip_protocol                  = "tcp"
  ingress                      = true
}

module "Egress_Rule_DB" {
  source            = "./modules/sg_rule"
  security_group_id = module.Security_Group_DB.security_group_id
  cidr_ipv4         = "127.0.0.1/32"
  from_port         = null
  to_port           = null
  ip_protocol       = "-1"
  egress            = true
}

########################################
# Call Network ACL Module
########################################
module "NACL_Subnet_Pub_1" {
  source           = "./modules/nacl"
  name             = "NACL Subnet Pub 1"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_ids       = [module.Subnet_Pub_1.subnet_id]
}

module "NACL_Subnet_Pub_2" {
  source           = "./modules/nacl"
  name             = "NACL Subnet Pub 2"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_ids       = [module.Subnet_Pub_2.subnet_id]
}

module "NACL_Subnet_Web_1" {
  source           = "./modules/nacl"
  name             = "NACL Subnet Web 1"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_ids       = [module.Subnet_Web_1.subnet_id]
}

module "NACL_Subnet_Web_2" {
  source           = "./modules/nacl"
  name             = "NACL Subnet Web 2"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_ids       = [module.Subnet_Web_2.subnet_id]
}

module "NACL_Subnet_App_1" {
  source           = "./modules/nacl"
  name             = "NACL Subnet App 1"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_ids       = [module.Subnet_App_1.subnet_id]
}

module "NACL_Subnet_App_2" {
  source           = "./modules/nacl"
  name             = "NACL Subnet App 2"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_ids       = [module.Subnet_App_2.subnet_id]
}

module "NACL_Subnet_DB_1" {
  source           = "./modules/nacl"
  name             = "NACL Subnet DB 1"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_ids       = [module.Subnet_DB_1.subnet_id]
}

module "NACL_Subnet_DB_2" {
  source           = "./modules/nacl"
  name             = "NACL Subnet DB 2"
  environment_name = var.environment_name
  vpc_id           = module.VPC.vpc_id
  subnet_ids       = [module.Subnet_DB_2.subnet_id]
}

########################################
# Call Network ACL Rule Module
########################################
module "Inbound_Rule_100_Pub_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Pub_1.network_acl_id
  rule_number    = "100"
  cidr_block     = "192.168.0.0/16"
  from_port      = 22
  to_port        = 22
}

module "Inbound_Rule_110_Pub_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Pub_1.network_acl_id
  rule_number    = "110"
  cidr_block     = module.Subnet_Web_1.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Outbound_Rule_100_Pub_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Pub_1.network_acl_id
  rule_number    = "100"
  egress         = true
  cidr_block     = "192.168.0.0/16"
  from_port      = 22
  to_port        = 22
}

module "Outbound_Rule_110_Pub_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Pub_1.network_acl_id
  rule_number    = "110"
  egress         = true
  cidr_block     = module.Subnet_Web_1.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Inbound_Rule_100_Pub_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Pub_2.network_acl_id
  rule_number    = "100"
  cidr_block     = "192.168.0.0/16"
  from_port      = 22
  to_port        = 22
}

module "Inbound_Rule_110_Pub_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Pub_2.network_acl_id
  rule_number    = "110"
  cidr_block     = module.Subnet_Web_2.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Outbound_Rule_100_Pub_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Pub_2.network_acl_id
  rule_number    = "100"
  egress         = true
  cidr_block     = "192.168.0.0/16"
  from_port      = 22
  to_port        = 22
}

module "Outbound_Rule_110_Pub_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Pub_2.network_acl_id
  rule_number    = "110"
  egress         = true
  cidr_block     = module.Subnet_Web_2.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Inbound_Rule_100_Web_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Web_1.network_acl_id
  rule_number    = "100"
  cidr_block     = module.Subnet_Pub_1.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Inbound_Rule_110_Web_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Web_1.network_acl_id
  rule_number    = "110"
  cidr_block     = module.Subnet_App_1.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Outbound_Rule_100_Web_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Web_1.network_acl_id
  rule_number    = "100"
  egress         = true
  cidr_block     = module.Subnet_Pub_1.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Outbound_Rule_110_Web_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Web_1.network_acl_id
  rule_number    = "110"
  egress         = true
  cidr_block     = module.Subnet_App_1.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Inbound_Rule_100_Web_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Web_2.network_acl_id
  rule_number    = "100"
  cidr_block     = module.Subnet_Pub_2.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Inbound_Rule_110_Web_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Web_2.network_acl_id
  rule_number    = "110"
  cidr_block     = module.Subnet_App_2.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Outbound_Rule_100_Web_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Web_2.network_acl_id
  rule_number    = "100"
  egress         = true
  cidr_block     = module.Subnet_Pub_2.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Outbound_Rule_110_Web_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_Web_2.network_acl_id
  rule_number    = "110"
  egress         = true
  cidr_block     = module.Subnet_App_2.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Inbound_Rule_100_App_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_App_1.network_acl_id
  rule_number    = "100"
  cidr_block     = module.Subnet_Web_1.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Inbound_Rule_110_App_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_App_1.network_acl_id
  rule_number    = "110"
  cidr_block     = module.Subnet_DB_1.subnet_cidr_block
  from_port      = 3306
  to_port        = 3306
}

module "Outbound_Rule_100_App_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_App_1.network_acl_id
  rule_number    = "100"
  egress         = true
  cidr_block     = module.Subnet_Web_1.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Outbound_Rule_110_App_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_App_1.network_acl_id
  rule_number    = "110"
  egress         = true
  cidr_block     = module.Subnet_DB_1.subnet_cidr_block
  from_port      = 3306
  to_port        = 3306
}

module "Inbound_Rule_100_App_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_App_2.network_acl_id
  rule_number    = "100"
  cidr_block     = module.Subnet_Web_2.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Inbound_Rule_110_App_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_App_2.network_acl_id
  rule_number    = "110"
  cidr_block     = module.Subnet_DB_2.subnet_cidr_block
  from_port      = 3306
  to_port        = 3306
}

module "Outbound_Rule_100_App_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_App_2.network_acl_id
  rule_number    = "100"
  egress         = true
  cidr_block     = module.Subnet_Web_2.subnet_cidr_block
  from_port      = 443
  to_port        = 443
}

module "Outbound_Rule_110_App_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_App_2.network_acl_id
  rule_number    = "110"
  egress         = true
  cidr_block     = module.Subnet_DB_2.subnet_cidr_block
  from_port      = 3306
  to_port        = 3306
}

module "Inbound_Rule_110_DB_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_DB_1.network_acl_id
  rule_number    = "110"
  cidr_block     = module.Subnet_App_1.subnet_cidr_block
  from_port      = 3306
  to_port        = 3306
}

module "Outbound_Rule_110_DB_1" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_DB_1.network_acl_id
  rule_number    = "110"
  egress         = true
  cidr_block     = module.Subnet_App_1.subnet_cidr_block
  from_port      = 3306
  to_port        = 3306
}

module "Inbound_Rule_110_DB_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_DB_2.network_acl_id
  rule_number    = "110"
  cidr_block     = module.Subnet_App_2.subnet_cidr_block
  from_port      = 3306
  to_port        = 3306
}

module "Outbound_Rule_110_DB_2" {
  source         = "./modules/nacl_rule"
  network_acl_id = module.NACL_Subnet_DB_2.network_acl_id
  rule_number    = "110"
  egress         = true
  cidr_block     = module.Subnet_App_2.subnet_cidr_block
  from_port      = 3306
  to_port        = 3306
}
