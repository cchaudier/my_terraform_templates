resource "aws_subnet" "publique_subnet" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "${var.aws_zone.a}"
}
