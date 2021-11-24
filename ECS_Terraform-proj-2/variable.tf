variable "vpc_cidr" {
  type = string
  default = ["10.10.0.0/16" ]
}

variable "my_region" {
  type = map
  default = ["us-east-1"]
}

variable "vpc_tag" {
    type = string
    default = ["dev_vpc"]
  
}

