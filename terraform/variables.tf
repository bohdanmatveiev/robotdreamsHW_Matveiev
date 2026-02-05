variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami" {
  description = "AMI ID для EC2"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 у us-east-1
}

variable "instance_type" {
  description = "Тип EC2 інстансу"
  type        = string
  default     = "t2.micro"
}
