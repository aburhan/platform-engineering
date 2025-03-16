output "vpc_id" {
  value = google_compute_network.vpc.id
}

output "proxy_subnet_id" {
  value = google_compute_subnetwork.proxy_subnet.id
}
