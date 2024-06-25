resource "aws_route_table" "devops_route_table" {
  vpc_id = data.aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "devops-public-route-table"
  }
}

resource "aws_route_table_association" "subnet_public_01" {
  route_table_id = aws_route_table.devops_route_table.id
  subnet_id      = data.aws_subnet.public_01
}

resource "aws_route_table_association" "subnet_public_02" {
  route_table_id = aws_route_table.devops_route_table.id
  subnet_id      = data.aws_subnet.public_02
}
