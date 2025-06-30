terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  required_version = ">= 1.0"

  backend "s3" {
  bucket         = "dstrunetss-terraform-state"
  key            = "lab1/terraform.tfstate"
  region         = "eu-north-1"
  encrypt = true
  dynamodb_table = "dstrunetss-terraform-lock"
}
}

