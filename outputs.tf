

output "boris_instance_public_ip_address" {
  value = aws_instance.boris_instance.public_ip
}