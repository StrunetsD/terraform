
output "web_server_public_ip" {
  description = "The IP of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}