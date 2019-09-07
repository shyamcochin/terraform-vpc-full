# Associate Public Subnet with Public Route Table
#------------------------------------------------
resource "aws_route_table_association" "public_subnet_assoc" {
  count          = "${length(var.public_cidrs)}"
  route_table_id = "${aws_route_table.public_route.id}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  depends_on     = ["aws_route_table.public_route", "aws_subnet.public_subnet"]
}

# Associate Private Subnet with Private Route Table
#--------------------------------------------------
resource "aws_route_table_association" "private_subnet_assoc" {
  count          = "${length(var.private_cidrs)}"
  route_table_id = "${aws_route_table.private_route.id}"
  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  depends_on     = ["aws_route_table.private_route", "aws_subnet.private_subnet"]
}
