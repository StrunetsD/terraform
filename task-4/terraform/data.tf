data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = var.ami_owner
  filter {
    name   = "name"
    values = [var.ami_name_pattern]
  }
  filter {
    name   = "virtualization-type"
    values = [var.ami_virtualization_type]
  }
}