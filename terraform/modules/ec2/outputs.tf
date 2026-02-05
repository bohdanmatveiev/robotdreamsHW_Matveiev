output "instance_id" {
  description = "ID EC2 інстансу"
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Публічний IP EC2 інстансу"
  value       = aws_instance.this.public_ip
}
