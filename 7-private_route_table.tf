# Private Route Table

resource "aws_route_table" "private_route" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = "${aws_eip.fornat.id}"
  }
  tags   = {
    Name = "Ola-Private-RT"
  }
}
