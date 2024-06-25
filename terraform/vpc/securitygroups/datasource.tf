data "aws_vpc" "vpc" {
  filter {
    name   = "tags:Name"
    values = ["devops-vpc"]
  }
}