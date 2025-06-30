variable "region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "eu-north-1"
}

variable "image_tag_mutability" {
    description = "Image tag mutability for ECR repository"
    type        = string
    default     = "MUTABLE"
}

variable "env" {
  type    = map(string)
  default = {}
}