resource "aws_ecr_repository" "devops_repository" {
  name                 = "devops-ecr"
  image_tag_mutability = "MUTABLE"
  tags = {
    Name = "devops-ecr"
  }
}
