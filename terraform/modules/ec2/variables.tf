variable "ami" {
  description = "AMI ID для EC2"
  type        = string
}

variable "instance_type" {
  description = "Тип EC2 інстансу"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "ID підмережі, де буде інстанс"
  type        = string
}

variable "name" {
  description = "Назва EC2 інстансу"
  type        = string
  default     = "ec2-instance"
}
