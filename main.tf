#Creating VPC

resource "google_compute_network" "vpc_network" {
  project                 = var.project_name
  name                    = var.vpc-name
  auto_create_subnetworks = false
  routing_mode = var.routing-mode
  delete_default_routes_on_create = true
}
resource "google_compute_subnetwork" "subnet-webapp" {
  name          = var.subnet1
  ip_cidr_range = var.subnet1-ip-range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "subnet-db" {
  name          = var.subnet2
  ip_cidr_range = var.subnet2-ip-range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_route" "webapp-route" {
  name = var.webapp-route
  network = google_compute_network.vpc_network.id
  dest_range = var.internet-ip
  next_hop_gateway = "default-internet-gateway"
}

#Firewall:
resource "google_compute_firewall" "allow-from-internet" {
  name    = var.allow-rule
  network = google_compute_network.vpc_network.name
  allow {
    protocol = var.protocol
    ports    = [var.app-port]
  }
  source_ranges = [var.internet-ip]
}
resource "google_compute_firewall" "deny-ssh-from-internet" {
  name    = var.deny-rule
  network = google_compute_network.vpc_network.name
  deny {
    protocol = var.protocol
    ports    = [var.ssh-port]
  }
  source_ranges = [var.internet-ip]
}
