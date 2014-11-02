# Routing table for public subnets

resource "aws_route_table" "publique_route" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}

resource "aws_route_table_association" "publique_route_association_a" {
  subnet_id = "${aws_subnet.publique_subnet_a.id}"
  route_table_id = "${aws_route_table.publique_route.id}"
}

resource "aws_route_table_association" "publique_route_association_b" {
  subnet_id = "${aws_subnet.publique_subnet_b.id}"
  route_table_id = "${aws_route_table.publique_route.id}"
}

# Routing table for private subnets

resource "aws_route_table" "private_route" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}

resource "aws_route_table_association" "private_route_association_a" {
  subnet_id = "${aws_subnet.private_subnet_a.id}"
  route_table_id = "${aws_route_table.private_route.id}"
}

resource "aws_route_table_association" "private_route_association_b" {
  subnet_id = "${aws_subnet.private_subnet_b.id}"
  route_table_id = "${aws_route_table.private_route.id}"
}
