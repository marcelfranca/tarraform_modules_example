resource "aws_vpc" "vpc" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
}

locals {
  subnet_map = { for subnet, att in var.subnets : att.cidr_block => att }
}

resource "aws_subnet" "subnets" {
  for_each          = local.subnet_map
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.av_zone
  tags              = each.value.tags
  vpc_id            = aws_vpc.vpc.id

  depends_on = [aws_vpc.vpc]
}

resource "aws_vpc_dhcp_options" "dhcp" {
  domain_name_servers = var.domain_name_server
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  dhcp_options_id = aws_vpc_dhcp_options.dhcp.id
  vpc_id          = aws_vpc.vpc.id

  depends_on = [aws_vpc_dhcp_options.dhcp, aws_vpc.vpc]
}

resource "aws_internet_gateway" "gw" {
  vpc_id     = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc]
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  dynamic "route" {
    for_each = var.route_table
    content {
      cidr_block = route.value["cidr_block"]
      gateway_id = aws_internet_gateway.gw.id
    }
  }
  depends_on = [aws_internet_gateway.gw]
}
