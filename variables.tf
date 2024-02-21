variable "project_name"{
type = string
}

variable "region"{
type = string
default = "us-east1"
}
##VPC & Subnets
variable "vpc-name"{
type = string
}
variable "subnet1"{
type = string
default = "webapp"
}

variable "subnet1-ip-range"{
type = string
default = "10.0.0.0/24"
}

variable "subnet2"{
type = string
default = "db"
}

variable "subnet2-ip-range"{
type = string
default = "10.0.1.0/24"
}


variable "webapp-route"{
type = string
default = "webapp-route"
}

variable "internet-ip"{
type = string
default = "0.0.0.0/0"
}

variable "routing-mode" {
  type = string
  default = "REGIONAL"
}

#firewall
variable "allow-rule" {
  type = string
  default = "allow-from-internet"
}
variable "deny-rule" {
  type = string
  default = "deny-ssh-from-internet"
}
variable "protocol" {
  type = string
}
variable "app-port" {
  type = string
  default = "8080"
}
variable "ssh-port" {
  type = string
  default = "22"
}



