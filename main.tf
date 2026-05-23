terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  # This locks your state persistence out of GitHub and routes it to GCP directly 🔐
  backend "gcs" {
    bucket = "state-bucket-project-4d670ee4"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = "project-4d670ee4-c2ac-4050-8e8"
}

# Advanced Network Module (v2.0.0)
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

# Variable declarations (Values are automatically injected via deploy.yml env strings)
variable "network_name" { type = string }
variable "subnet_cidr"  { type = string }
variable "region"       { type = string }