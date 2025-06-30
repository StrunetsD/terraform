module "vpc" {
  name = var.main_vpc
  cidr = var.cidr_block_vpc
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  azs = slice(data.aws_availability_zones.available.names, 0, 2) 
  public_subnets = [
    for k, v in slice(data.aws_availability_zones.available.names, 0, 2) :
    cidrsubnet(var.cidr_block_vpc, 8, k + 4)
  ]
  map_public_ip_on_launch = true
}