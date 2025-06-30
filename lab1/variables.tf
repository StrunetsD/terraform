variable "ami_owner" {
  description = "Owner of the AMI (e.g., 'amazon' or 'canonical')"
  type        = list(string)
  default     = ["amazon"]
}

variable "ami_name_pattern" {
  description = "Pattern for the AMI name"
  type        = string
  default     = "amzn2-ami-hvm-*-x86_64-gp2"
}

variable "ami_virtualization_type" {
  description = "Virtualization type of the AMI (e.g., 'hvm')"
  type        = string
  default     = "hvm"
}

variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "eu-north-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "trainee-project"
}

variable "env" {
  type    = string
  default = ""
}

variable "instance_configs" {
  type = map(string) 
  default = {
     "backend": "t3.micro"
     "frontend": "t3.nano"
  } 
}

variable "security_group_name" {
  description = "Name of the security group"
  type        = string
  default     = "main_security_group"
}

variable "to_port_security_group" {
  description = "Port for the security group"
  type        = number
  default     = 22
}

variable "from_port_security_group" {
  description = "From port for the security group"
  type        = number
  default     = 22
}

variable "protocol_security_group" {
  description = "Protocol for the security group"
  type        = string
  default     = "tcp"
}

variable "cidr_blocks_security_group" {
  description = "CIDR blocks for the security group"
  type        = list(string)
  default     = [] 
}

variable "from_port_http_security_group" {
  description = "From port for HTTP in the security group"
  type        = number
  default     = 80
}

variable "to_port_http_security_group" {
  description = "To port for HTTP in the security group"
  type        = number
  default     = 80
}

variable "protocol_http_security_group" {
  description = "Protocol for HTTP in the security group"
  type        = string
  default     = "tcp"
}

variable "cidr_blocks_http_security_group" {
  description = "CIDR blocks for HTTP in the security group"
  type        = list(string)
  default     = []
}

variable "from_port_outbound_security_group" {
  description = "From port for outbound traffic in the security group"
  type        = number
  default     = 0
}

variable "to_port_outbound_security_group" {
  description = "To port for outbound traffic in the security group"
  type        = number
  default     = 0
}

variable "protocol_outbound_security_group" {
  description = "Protocol for outbound traffic in the security group"
  type        = string
  default     = "-1"
}

variable "cidr_blocks_outbound_security_group" {
  description = "CIDR blocks for outbound traffic in the security group"
  type        = list(string)
  default     = []
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "main_vpc"
}

variable "cidr_block_vpc" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "main_vpc" {
  description = "value for main_vpc"
  type        = string
  default     = "vpc"
}
