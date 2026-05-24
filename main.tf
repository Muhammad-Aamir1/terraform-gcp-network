resource "google_compute_network" "vpc" {
  name                    = var.network_name
  auto_create_subnetworks = false # Manual subnet management enabled
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.network_name}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
}
#adding a comment to trigger a new commit for the demo here. This is the main.tf file for the terraform-gcp-network module, which defines a VPC network and a subnet with parameters passed in from the root module.
