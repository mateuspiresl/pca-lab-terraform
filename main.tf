terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.55.0, < 6.0.1"
    }
  }

  backend "gcs" {
    bucket = "tf-bucket-632599"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "6.0.0"

  project_id   = var.project_id
  network_name = "tf-vpc-445771"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name   = "subnet-01"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-central1"
    },
    {
      subnet_name   = "subnet-02"
      subnet_ip     = "10.10.20.0/24"
      subnet_region = "us-central1"
    }
  ]
}

resource "google_compute_firewall" "tf-firewall" {
  name          = "tf-firewall"
  network       = module.vpc.network_name
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

module "instances" {
  source = "./modules/instances"

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
}

module "storage" {
  source = "./modules/storage"

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
}
