# Routing table for public subnets

resource "aws_route_table" "publique_route" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}

resource "aws_route_table_association" "publique_route_association" {
  subnet_id = "${aws_subnet.publique_subnet.id}"
  route_table_id = "${aws_route_table.publique_route.id}"
}
