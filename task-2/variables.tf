variable "public_subnet_A_cidr" {
  description = "CIDR block for public subnet A"
  type        = list(string)
  default     = []
}

variable "public_subnet_B_cidr" {
  description = "CIDR block for public subnet B"
  type        = list(string)
  default     = []
}

variable "availability_zone" {
    description = "Availability zone for the subnets"
    type        = map(string)
    default     = {}
}

variable "main_cidr_block" {
  description = "CIDR block for the main VPC"
  type        = string
  default     = ""
}