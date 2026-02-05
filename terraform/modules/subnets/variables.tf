variable "vpc_id" {
  description = "ID VPC"
  type        = string
}

variable "public_cidr" {
  description = "CIDR блок для публічної підмережі"
  type        = string
}

variable "private_cidr" {
  description = "CIDR блок для приватної підмережі"
  type        = string
}
