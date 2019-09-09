# Private Route Table

resource "aws_route_table" "private_route" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = "${element(aws_nat_gateway.nat.*.id, 0)}" #here we have set the index manually
  }
  tags   = {
    Name = "Ola-Private-RT"
  }
}

/*
  using the following code, we can dynamically adjust the nat id.
    resource "aws_route_table" "private_route" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    route {
      cidr_block     = "0.0.0.0/0"
      gateway_id     = "${element(aws_nat_gateway.nat.*.id, index(aws_nat_gateway.nat))}"   using this we can get the count/index of nat gateway.
    }
    tags   = {
      Name = "Ola-Private-RT"
    }
  }

*/
