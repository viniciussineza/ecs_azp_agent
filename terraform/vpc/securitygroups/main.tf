resource "aws_security_group" "devops_security_group" {
  name   = "devops-security-group"
  vpc_id = ""
  tags = {
    Name = "devops-security-group"
  }
}

resource "aws_security_group_rule" "ingress_01" {
  type              = "ingress"
  to_port           = 0
  from_port         = 0
  protocol          = -1
  self              = true
  security_group_id = aws_security_group.devops_security_group.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  to_port           = 0
  from_port         = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.devops_security_group.id
}
