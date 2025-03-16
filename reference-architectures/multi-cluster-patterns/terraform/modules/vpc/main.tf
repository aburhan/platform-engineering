resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = true
  project                 = var.project_id
}

resource "google_compute_subnetwork" "proxy_subnet" {
  name          = var.proxy_subnet_name
  ip_cidr_range = var.proxy_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  project       = var.project_id
}
