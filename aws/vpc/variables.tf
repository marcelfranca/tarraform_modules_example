// REQUIRED
variable "cidr_block" {
  type        = string
  description = "Cidr block to be associated with the vpc"
}

variable "subnets" {
  type = list(object({
    cidr_block              = string
    av_zone                 = string
    map_public_ip_on_launch = bool
    tags                    = map(string)
  }))
  description = "IP/Cidrs of subnets to be created"
}

// OPTIONAL
variable "instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr."
  default     = "default"
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "enable_classiclink" {
  type    = bool
  default = false
}

variable "enable_classiclink_dns_support" {
  type    = bool
  default = false
}

variable "assign_generated_ipv6_cidr_block" {
  type    = bool
  default = false
}

variable "domain_name_server" {
  type        = list(string)
  description = "List of name servers to configure in /etc/resolv.conf"
  default     = ["AmazonProvidedDNS"]
}

variable "route_table" {
  type = list(object({
    cidr_block : string
  }))
  default = [
    {
      cidr_block = "0.0.0.0/0"
    }]
}

variable "tag" {
  type = map(string)
}
