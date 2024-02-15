#Creating VPC

resource "google_compute_network" "vpc_network" {
  project                 = var.project_name
  name                    = "vpc-${var.env}"
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
  delete_default_routes_on_create = true
}
resource "google_compute_subnetwork" "subnet-webapp" {
  name          = var.subnet1
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "subnet-db" {
  name          = var.subnet2
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_route" "webapp-route" {
  name = var.webapp-route
  network = google_compute_network.vpc_network.id
  dest_range = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
}