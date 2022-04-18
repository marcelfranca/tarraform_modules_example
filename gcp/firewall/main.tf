locals {
  # configs_map = {for config, att in var.configs : att.protocol => att}
  config_map = set(var.configs)
}

output "config_map" {
  value = local.config_map
}

resource "google_compute_firewall" "firewall" {
    name = var.firewall_name
    network = var.vpc_name

  dynamic "allow" {
    for_each = local.config_map
    content {
      protocol = config.value["protocol"]
      ports = config.value["ports"]
    }
  }  
    source_ranges = var.source_ranges
}