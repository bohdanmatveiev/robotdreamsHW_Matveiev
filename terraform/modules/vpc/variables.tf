variable "cidr_block" {
  description = "CIDR блок для VPC"
  type        = string
}

variable "name" {
  description = "Назва VPC"
  type        = string
  default     = "my-vpc"
}
