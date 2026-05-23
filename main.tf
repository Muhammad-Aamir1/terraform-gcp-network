# # Basic Network Module (v1.0.0)
# resource "google_compute_network" "vpc" {
#   name                    = var.network_name
#   auto_create_subnetworks = true
# }

# variable "network_name" {
#   type        = string
#   description = "The name of the VPC network"
# }

# Advanced Network Module (v2.0.0)
resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false # Team B requires manual subnet control
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.network_name}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}

variable "network_name" { type = string }
variable "subnet_cidr"  { type = string }
variable "region"       { type = string }

#adding a comment to trigger a new commit for the demo