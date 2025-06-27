output "vpcs" {
  description = "VPC Outputs"
  value = {
  name       = aws_vpc.main_vpc.tags.Name
  cidr_block = aws_vpc.main_vpc.cidr_block
  id = aws_vpc.main_vpc.id
  }
}