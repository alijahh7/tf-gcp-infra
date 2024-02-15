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

variable "subnet1"{
type = string
default = "webapp"
}

variable "subnet2"{
type = string
default = "db"
}

variable "webapp-route"{
type = string
default = "webapp-route"
}

