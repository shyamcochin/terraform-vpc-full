### Public Route Table
#---------------------
resource "aws_route_table" "public_route" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags   = {
    Name = "Ola-Public-RT"
  }
}
