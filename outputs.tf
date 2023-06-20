output "instance_private_ip_addr" {
  value = aws_instance.bot_container.private_ip
}

output "instance_public_ip_addr" {
  value = aws_instance.bot_container.public_ip
}