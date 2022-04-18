// REQUIRED

variable "name" {
  type        = string
  description = "cluster name"
}

variable "project_id" {
  type        = string
  description = "The project id  to which the cluster is associated"
}

variable "namespace" {
  type        = string
  description = "Project namespace to use for unique resource naming"
}

variable "vpc_name" {
  type        = string
  description = "The VPC name where your cluster runs"
}

variable "subnetwork_name" {
  type        = string
  description = "The vpc subnet where your instances will run"
}

variable "vpc_pod_network" {
  type        = string
  description = "The name of the POD subnet in a VPC"
}

variable "vpc_service_network" {
  type        = string
  description = "The name of the POD subnet in a VPC"
}

variable "node_count" {
  type        = number
  description = "number of nodes in the cluster"
}

variable "credentials_files" {
  type = string
  description = "Path to .json service account file to GCP"
}

variable "remote_storage" {
  type = string
  description = "Name of the remote storage bucket"
}

// OPTIONAL

variable "networking_mode" {
  type        = string
  description = "The networking mode you would like to use [VPC_NATIVE | ROUTES]"

  validation {
    condition     = can(regex("^VPC_NATIVE", var.networking_mode)) || can(regex("^ROUTES", var.networking_mode))
    error_message = "Value can only be: VPC_NATIVE or ROUTES."
  }

  default = "VPC_NATIVE"
}

variable "service_account_file_path" {
  type        = string
  description = "Service account file location"
  default     = null
}

variable "region" {
  type        = string
  description = "GCP zone"
  default     = "us-east1"
}

variable "zone" {
  type        = list(string)
  description = "GCP zone"
  default     = ["us-east1-b"]
}

variable "machine_type" {
  type        = string
  description = "nodes machine type"
  default     = "e2-small"
}

variable "remote_storage_directory" {
  type = string
  description = "Directory for the remote storage"
  default = ""
}

variable "preemptible" {
  type = bool
  description = "Set node to be preemptible"
  default = false
}
