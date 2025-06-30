resource "aws_ecr_repository" "dstrunetss-ecr-repo" {
  name                 = "dstrunetss-ecr-repo"
  image_tag_mutability = var.image_tag_mutability

  tags = {
    Name        = "dstrunetss-ecr-repo"
    Environment = var.env["backend"]
  }
  
}