provider "aws" {
    region = var.region 

    default_tags {
      tags = {
        Owner       = "dstrunetss"
      }
    }
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  required_version = ">= 1.0"
}

resource "aws_s3_bucket" "dstrunetss-terraform-state" {
  force_destroy = false
  bucket        = "dstrunetss-terraform-state"

  tags = {
    Name        = "dstrunetss-terraform-state"
    Environment = "Backend"
    Owner       = "Иван Иванов" 
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_bucket_versioning" {
  bucket = aws_s3_bucket.dstrunetss-terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_bucket_encryption" {
  bucket = aws_s3_bucket.dstrunetss-terraform-state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_bucket_public_access" {
  bucket                  = aws_s3_bucket.dstrunetss-terraform-state.id
  block_public_acls       = true
  ignore_public_acls      = true
}

resource "aws_dynamodb_table" "dstrunetss-terraform-lock" {
  name         = "dstrunetss-terraform-lock"
  billing_mode = "PAY_PER_REQUEST" # PROVISIONED -- if you want to set read/write capacity
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "dstrunetss-terraform-lock"
  }
  
}