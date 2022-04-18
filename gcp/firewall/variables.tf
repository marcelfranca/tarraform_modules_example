// REQUIRED
variable "firewall_name" {
    type = string
    description = "Firewall name"
}

variable "vpc_name" {
    type = string
    description = "VPC to attach the firewall"
}

variable "configs" {

  type    = list(map(list(number)))
  default = [{ tcp : [8080, 80, 442] }, { udp : [21] }]
}

variable "source_ranges" {
  type        = list(string)
  description = "A list of source CIDR range to apply this rule."
}
