resource "aws_subnet" "publique_subnet_a" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    cidr_block = "10.0.1.0/24"
    availability_zone = "${var.aws_zone.a}"
}

resource "aws_subnet" "publique_subnet_b" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    cidr_block = "10.0.2.0/24"
    availability_zone = "${var.aws_zone.b}"
}

resource "aws_subnet" "private_subnet_a" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    cidr_block = "10.0.11.0/24"
    availability_zone = "${var.aws_zone.a}"
}

resource "aws_subnet" "private_subnet_b" {
    vpc_id = "${aws_vpc.my_vpc.id}"
    cidr_block = "10.0.12.0/24"
    availability_zone = "${var.aws_zone.b}"
}

resource "aws_db_subnet_group" "db_private_subnet" {
    name = "db_private_subnet"
    description = "Our main group of db subnets"
    subnet_ids = [
      "${aws_subnet.private_subnet_a.id}", 
      "${aws_subnet.private_subnet_b.id}", 
      "${aws_subnet.publique_subnet_a.id}", 
      "${aws_subnet.publique_subnet_b.id}"
    ]
}
