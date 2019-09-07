### VPC Creation
#---------------
resource "aws_vpc" "my_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags   = {
    Name = "Ola_VPC"
  }
}

### Public Subnet
#----------------
resource "aws_subnet" "public_subnet" {
  count                   = "${length(var.public_cidrs)}"
  cidr_block              = "${element(var.public_cidrs, count.index)}"
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  map_public_ip_on_launch = true
  availability_zone       = "${element(var.azs, count.index)}"

  tags   = {
    Name = "OlaSubnet-Public${count.index + 1}"
  }
}

### Private Subnet
#-----------------
resource "aws_subnet" "private_subnet" {
  count                   = "${length(var.private_cidrs)}"
  cidr_block              = "${element(var.private_cidrs, count.index)}"
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  map_public_ip_on_launch = false
  availability_zone       = "${element(var.azs, count.index)}"

  tags   = {
    Name = "OlaSubnet-Private${count.index + 1}"
  }
}

output "vpc_id" {
  value = "${aws_vpc.my_vpc.id}"
}

output "subnet_id" {
  value = "${aws_subnet.public_subnet.*.id}"
}

output "private_subnets" {
  value = "${aws_subnet.private_subnet.*.id}"
}

output "security_group" {
  value = "${aws_security_group.web.id}"
}
