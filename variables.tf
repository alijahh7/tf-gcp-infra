variable "project_name"{
type = string
}

variable "region"{
type = string
default = "us-east1"
}

variable "env"{
type = string
}

##VPC & Subnets

variable "i" {
  type    = number
  default = 100
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



