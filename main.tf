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

# Firewall:
resource "google_compute_firewall" "allow-from-internet" {
  name    = var.allow-rule
  network = google_compute_network.vpc_network.name
  priority = var.allow-priority
  allow {
    protocol = var.protocol
    ports    = [var.app-port]
  }
  source_ranges = [var.internet-ip]
  target_tags = [var.webapp-subnet-tag]
}
resource "google_compute_firewall" "deny-ssh-from-internet" {
  name    = var.deny-rule
  network = google_compute_network.vpc_network.name
  priority = var.allow-priority+1
  deny {
    protocol = var.protocol
    ports    = []
  }
  source_ranges = [var.internet-ip]
}
# VM:
resource "google_compute_instance" "centos-vm" {
  name         = var.vm-name
  machine_type = var.vm-type
  zone         = "${var.region}-${var.vm-zone-append}"
   depends_on   = [google_compute_network.vpc_network]
boot_disk {
    initialize_params {
      image = var.custom-image-family
      size  = var.boot-disk-size   
      type  = var.boot-disk-type
    }
  }
network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet-webapp.id
    access_config {
      //Empty --> Ephemeral IP (dynamic)
    }
  }
  tags = [var.webapp-subnet-tag]
}
