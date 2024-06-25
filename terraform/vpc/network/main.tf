resource "aws_vpc" "vpc" {
  cidr_block = "10.1.1.0/28"
  tags = {
    Name = "devops-vpc"
  }
}

resource "aws_subnet" "public_01" {
  cidr_block = "10.1.1.0/29"
  vpc_id     = aws_vpc.vpc.id
  tags = {
    Name = "devops-public-01"
  }
}

resource "aws_subnet" "public_02" {
  cidr_block = "10.1.1.8/29"
  vpc_id     = aws_vpc.vpc.id
  tags = {
    Name = "devops-public-02"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "devops-igw"
  }
}
