### Creating Elastic IP for NAT Gateway
#--------------------------------------
resource "aws_eip" "fornat" {
  vpc      = true
}

### Creating NAT Gateway for Private Subnets
#-------------------------------------------
resource "aws_nat_gateway" "nat" {
  count         = 1
  allocation_id = "${aws_eip.fornat.id}"
  subnet_id     = "${element(aws_subnet.public_subnet.*.id,count.index)}"
  depends_on    = ["aws_internet_gateway.gw"]

  tags = {
    Name = "Ola-NAT-GW"
  }
}
