variable "environment_name" {
  type    = string
  default = "Project001"
}

variable "name" {
  type = string
}

variable "subnet_ids" {
  type = list(any)
}

variable "vpc_id" {
  type = string
}
