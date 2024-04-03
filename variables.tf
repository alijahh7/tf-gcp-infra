variable "project_name" {
  type = string
}

variable "region" {
  type    = string
  default = "us-east1"
}
##VPC & Subnets
variable "vpc-name" {
  type = string
}
variable "subnet1" {
  type    = string
  default = "webapp"
}

variable "subnet1-ip-range" {
  type    = string
  default = "10.0.0.0/24"
}

variable "subnet2" {
  type    = string
  default = "db"
}

variable "subnet2-ip-range" {
  type    = string
  default = "10.0.1.0/24"
}


variable "webapp-route" {
  type    = string
  default = "webapp-route"
}

variable "internet-ip" {
  type    = string
  default = "0.0.0.0/0"
}

variable "routing-mode" {
  type    = string
  default = "REGIONAL"
}

variable "next-hop" {
  type    = string
  default = "default-internet-gateway"
}

#firewall
variable "allow-rule" {
  type    = string
  default = "allow-from-internet"
}
variable "deny-rule" {
  type    = string
  default = "deny-ssh-from-internet"
}
variable "protocol" {
  type = string
}
variable "app-port" {
  type    = string
  default = "8080"
}
variable "ssh-port" {
  type    = string
  default = "22"
}
#vm
variable "vm-name" {
  type    = string
  default = "app-vm"
}
variable "vm-type" {
  type    = string
  default = "e2-standard-2"
}
variable "vm-zone-append" {
  type    = string
  default = "a"
}
variable "custom-image-family" {
  type = string
}
variable "boot-disk-size" {
  type    = number
  default = 100
}
variable "boot-disk-type" {
  type    = string
  default = "pd-balanced"
}
#tags
variable "webapp-subnet-tag" {
  type    = string
  default = "webapp"
}

variable "allow-priority" {
  type    = number
  default = 1000
}

#a5:
variable "private-ip-name" {
  type    = string
  default = "private-ip2"
}

variable "private-ip-address-type" {
  type    = string
  default = "INTERNAL"
}

variable "private-ip-purpose" {
  type    = string
  default = "VPC-PEERING"
}

variable "private-ip-address" {
  type    = string
  default = "10.10.0.0"
}

variable "private-ip-prefix" {
  type    = number
  default = 24
}
#vpc conn
variable "vpc-conn-service" {
  type    = string
  default = "servicenetworking.googleapis.com"
}
variable "deletion_policy_abandon" {
  type = string
}
#sql instance
variable "instance-name" {
  type    = string
  default = "mydb2"
}

variable "instance-database-version" {
  type    = string
  default = "POSTGRES-12"
}

variable "instance-delete-protect" {
  type    = bool
  default = false
}
#settings
variable "instance-tier" {
  type    = string
  default = "db-f1-micro"
}

variable "instance-disk-resize" {
  type    = bool
  default = false
}

variable "instance-disk-size" {
  type    = number
  default = 100
}

variable "instance-disk-type" {
  type    = string
  default = "pd-ssd"
}

variable "instance-availability" {
  type    = string
  default = "REGIONAL"
}

variable "instance-delete-protect-enabled" {
  type    = bool
  default = false
}
#ipconfig
variable "instance-ipv4-enabled" {
  type    = bool
  default = false
}
#db
variable "database-name" {
  type    = string
  default = "mydb"
}

variable "database-password-length" {
  type    = number
  default = 16
}

variable "database-special" {
  type    = bool
  default = true
}

variable "database-override-special" {
  type    = string
  default = "!#$%&*()--=+[]{}<>:?"
}
#dbuser
variable "database-user" {
  type    = string
  default = "webapp"
}
#startup script
variable "startup_script_path" {
  type    = string
  default = "./startup.sh"
}
#dns
variable "domain_name" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

variable "dns_ttl" {
  type = number
}

variable "dns_record_type" {
  type = string
}

#service account for VM
variable "sa_account_id" {
  type = string
}
variable "sa_display_name" {
  type = string
}
#IAM for SA
variable "logging_role" {
  type = string
}

variable "metrics_role" {
  type = string
}
variable "vm_sa_scope" {
  type = string
}

variable "pubsub_role" {
  type = string
}
variable "pubsub_topic" {
  type = string
}
variable "pubsub_duration" {
  type = string
}

variable "vpc_connector_name" {
  type = string
}
variable "vpc_connector_ip" {
  type = string
}
variable "cloudfn_name" {
  type = string
}
variable "cloudfn_location" {
  type = string
}
variable "cloudfn_description" {
  type = string
}
variable "cloudfn_buildconf_runtime" {
  type = string
}
variable "cloudfn_buildconf_entry_point" {
  type = string
}
variable "cloudfn_buildconf_test" {
  type = string
}
variable "cloudfn_storage_bucket" {
  type = string
}
variable "cloudfn_storage_object" {
  type = string
}
variable "cloudfn_serviceconf_max_instance" {
  type = number
}
variable "cloudfn_serviceconf_min_instance" {
  type = number
}
variable "cloudfn_serviceconf_available_memory" {
  type = string
}
variable "cloudfn_serviceconf_timeout_seconds" {
  type = number
}
variable "cloudfn_serviceconf_test" {
  type = string
}
variable "cloudfn_serviceconf_ingress" {
  type = string
}
variable "cloudfn_serviceconf_latest_revision" {
  type = bool
}
variable "cloudfn_eventtrig_region" {
  type = string
}
variable "cloudfn_eventtrig_type" {
  type = string
}
variable "cloudfn_eventtrig_retry_policy" {
  type = string
}
variable "mailgun_key" {
  type = string
}
#health check firewall
variable "allow-health-check-rule" {
  type = string
}
variable "health-check-ip1"{
  type = string
}
variable "health-check-ip2" {
  type = string
}

#health check
variable "health_check_name" {
  type = string
}
variable "health_check_description" {
  type = string
  default = "Health check via /healthz"
}
variable "hc_timeout_sec" {
  type = number
}
variable "hc_check_interval" {
  type = number
}
variable "hc_healthy_threshold" {
  type = number
}
variable "hc_unhealthy_threshold" {
  type = number
}
variable "hc_port" {
  type = string
}
variable "hc_req_path" {
  type = string
}

#MIG
variable "mig_name" {
  type = string
}
variable "mig_base_name" {
  type = string
}
variable "mig_zone_a" {
  type = string
}
variable "mig_zone_f" {
  type = string
}
variable "mig_lb_named_port_number" {
  type = number
}
variable "mig_lb_named_port_name" {
  type = string
}
variable "mig_auto_heal_delay" {
  type = number
}

#autoscaler
variable "as_name" {
  type = string
}
variable "as_policy_max_replicas" {
  type = number
}

variable "as_policy_min_replicas" {
  type = number
}
variable "as_policy_cooldown" {
  type = number
}
variable "as_cpu_util_percent" {
  type = number
}

#LB subnet
variable "lb_subnet_name" {
  type = string
}
variable "lb_subnet_cidr" {
  type = string
}
variable "lb_subnet_purpose" {
  type = string
}
variable "lb_subnet_role" {
  type = string
}
#LB forwarding rule
variable "lb_fr_name" {
  type = string
}
variable "lb_fr_ip_protocol" {
  type = string
}
variable "lb_fr_balancing_scheme" {
  type = string
}
variable "lb_fr_port_range" {
  type = string
}
variable "lb_fr_network_tier" {
  type = string
}
#LB url map
variable "lb_urlmap_name" {
  type = string
}
#LB backend service
variable "lb_bs_name" {
  type = string
}
variable "lb_bs_protocol"{
  type = string
}
variable "lb_bs_timeout" {
  type = number
}
variable "lb_bs_load_balancing_scheme" {
  type = string
}
variable "lb_bs_backend_balancing_mode" {
  type = string
}
variable "lb_bs_backend_capacity_scaler" {
  type = number
}
variable "cert_name" {
  type = string
}
variable "cert_pk_path" {
  type = string
}
variable "cert_crt_path" {
  type = string
}
#https proxy
variable "https_proxy_name" {
  type = string
}