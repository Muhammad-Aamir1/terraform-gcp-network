# terraform {
#   required_version = ">= 1.0.0"
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "~> 5.0"
#     }
#   }
# }

# provider "google" {
#   project = var.project
# }

terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"  # Adjust to your needed version
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}