### Security Group for FrontEnd
#------------------------------
resource "aws_security_group" "web" {
  name        = "Ola-Web-SG"
  tags   = {
    Name = "Ola-Web-SG"
  }

  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = "${aws_vpc.my_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

# All OutBound Access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### Security Group for BackEnd
#-----------------------------
resource "aws_security_group" "db" {
  name        = "Ola-DB-SG"
  tags   = {
    Name = "Ola-DB-SG"
  }

  description = "Allow SSH and DB inbound traffic"
  vpc_id      = "${aws_vpc.my_vpc.id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    security_groups = ["${aws_security_group.web.id}"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
