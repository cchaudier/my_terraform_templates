resource "aws_vpc" "my_vpc" {
	cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.my_vpc.id}"
}

