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
