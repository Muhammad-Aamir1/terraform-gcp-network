# Basic Network Module (v1.0.0)
resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = true
}

variable "network_name" {
  type        = string
  description = "The name of the VPC network"
}