#Creating VPC

resource "google_compute_network" "vpc_network" {
  project                         = var.project_name
  name                            = var.vpc-name
  auto_create_subnetworks         = false
  routing_mode                    = var.routing-mode
  delete_default_routes_on_crate = true
}
resource "google_compute_subnetwork" "subnet-webapp" {
  name          = var.subnet1
  ip_cidr_range = var.subnet1-ip-range
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "subnet-db" {
  name                     = var.subnet2
  ip_cidr_range            = var.subnet2-ip-range
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}

resource "google_compute_route" "webapp-route" {
  name             = var.webapp-route
  network          = google_compute_network.vpc_network.id
  dest_range       = var.internet-ip
  next_hop_gateway = var.next-hop
}

# Firewall:
resource "google_compute_firewall" "allow-from-internet" {
  name     = var.allow-rule
  network  = google_compute_network.vpc_network.name
  priority = var.allow-priority
  allow {
    protocol = var.protocol
    ports    = [var.app-port]
  }
  source_ranges = [var.internet-ip]
  target_tags   = [var.webapp-subnet-tag]
}
resource "google_compute_firewall" "deny-ssh-from-internet" {
  name     = var.deny-rule
  network  = google_compute_network.vpc_network.name
  priority = var.allow-priority + 1
  deny {
    protocol = var.protocol
    ports    = []
  }
  source_ranges = [var.internet-ip]
}

resource "google_compute_global_address" "private_ip_db" {
  provider      = google
  project       = google_compute_network.vpc_network.project
  name          = var.private-ip-name
  address_type  = var.private-ip-address-type
  purpose       = var.private-ip-purpose
  network       = google_compute_network.vpc_network.id
  address       = var.private-ip-address
  prefix_length = var.private-ip-prefix
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_network.id
  service                 = var.vpc-conn-service
  reserved_peering_ranges = [google_compute_global_address.private_ip_db.name]
  deletion_policy         = var.deletion_policy_abandon
}

resource "google_sql_database_instance" "my_postgres_instance" {
  name                = var.instance-name
  database_version    = var.instance-database-version
  region              = var.region
  deletion_protection = var.instance-delete-protect
  depends_on          = [google_compute_network.vpc_network, google_service_networking_connection.private_vpc_connection]

  settings {
    tier                        = var.instance-tier
    disk_autoresize             = var.instance-disk-resize
    disk_size                   = var.instance-disk-size
    disk_type                   = var.instance-disk-type
    availability_type           = var.instance-availability
    deletion_protection_enabled = var.instance-delete-protect-enabled

    ip_configuration {
      ipv4_enabled    = var.instance-ipv4-enabled
      private_network = google_compute_network.vpc_network.id
    }

  }
}

resource "google_sql_database" "psql_database" {
  name     = var.database-name
  instance = google_sql_database_instance.my_postgres_instance.name
}

resource "random_password" "psql_pass" {
  length           = var.database-password-length
  special          = var.database-special
  override_special = var.database-override-special
}

resource "google_sql_user" "psql_user" {
  name     = var.database-user
  instance = google_sql_database_instance.my_postgres_instance.name
  password = random_password.psql_pass.result
}

# VM:
resource "google_compute_instance" "centos-vm" {
  name         = var.vm-name
  machine_type = var.vm-type
  zone         = "${var.region}-${var.vm-zone-append}"
  #depends_on   = [google_compute_network.vpc_network]
  depends_on = [google_compute_network.vpc_network, google_service_account.vm_service_account, google_sql_database_instance.my_postgres_instance]

  boot_disk {
    initialize_params {
      image = var.custom-image-family
      size  = var.boot-disk-size
      type  = var.boot-disk-type
    }
  }
  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet-webapp.id
    access_config {
      //Empty --> Ephemeral IP (dynamic)
    }
  }
  tags = [var.webapp-subnet-tag]

  metadata = {
    db-host = google_sql_database_instance.my_postgres_instance.private_ip_address
    db-user = google_sql_user.psql_user.name
    db-pass = google_sql_user.psql_user.password
    db-name = google_sql_database.psql_database.name
  }
  metadata_startup_script = file(var.startup_script_path)
  service_account {
    email  = google_service_account.vm_service_account.email
    scopes = [var.vm_sa_scope]
  }

}
#DNS record set
resource "google_dns_record_set" "dns_record" {
  name         = var.domain_name
  managed_zone = var.dns_zone_name
  type         = var.dns_record_type
  ttl          = var.dns_ttl

  rrdatas = [google_compute_instance.centos-vm.network_interface[0].access_config[0].nat_ip]

}

#Service Account for VM
resource "google_service_account" "vm_service_account" {
  account_id   = var.sa_account_id
  display_name = var.sa_display_name
}

#IAM Roles for SA:
resource "google_project_iam_binding" "role_logging" {
  project = var.project_name
  role    = var.logging_role

  members = [
    "serviceAccount:${google_service_account.vm_service_account.email}"
  ]
}

resource "google_project_iam_binding" "role_monitoring_metric_writer" {
  project = var.project_name
  role    = var.metrics_role

  members = [
    "serviceAccount:${google_service_account.vm_service_account.email}"
  ]
}
