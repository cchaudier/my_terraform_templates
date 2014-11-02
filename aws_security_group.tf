# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "web_sg" {
    name = "web_sg"
    description = "Machines Web"

    # SSH access from anywhere
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # HTTP access from anywhere
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

	vpc_id = "${aws_vpc.my_vpc.id}"
}

resource "aws_security_group" "rds_sg" {
    name = "rds_sg"
    description = "RDS Web"

    # pg port access from anywhere
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

	vpc_id = "${aws_vpc.my_vpc.id}"
}

resource "aws_db_security_group" "db_sg" {
  name = "db_sg"
  description = "RDS security groupe"
}
