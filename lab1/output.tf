output "public_ip_of_ec2_instances" {
  value = { for instance in aws_instance.ec2 : instance.id => instance.public_ip }
}