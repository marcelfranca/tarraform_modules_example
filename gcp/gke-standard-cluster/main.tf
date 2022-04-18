resource "google_container_cluster" "gke_cluster" {
  provider = google-beta

  name     = var.name
  location = var.region

  node_locations = var.zone
  initial_node_count       = 1
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  remove_default_node_pool = true

  networking_mode = var.networking_mode
  network         = var.vpc_name
  subnetwork      = var.subnetwork_name

  ip_allocation_policy {
    cluster_secondary_range_name  = var.vpc_pod_network
    services_secondary_range_name = var.vpc_service_network
  }

}


resource "google_container_node_pool" "gke_cluster_node_pool" {
  name       = "${google_container_cluster.gke_cluster.name}-node-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.region
  node_count = var.node_count

  node_config {
    preemptible  = var.preemptible
    machine_type = var.machine_type

    metadata = {
      disable-legacy-endpoints = "true"
      managed_by               = "TF"
    }
  }
}
