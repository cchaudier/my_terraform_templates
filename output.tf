output "elastic_public_ip" {
  value = "${aws_eip.web_ip.public_ip}"
}

output "db_endpoint" {
  value = "${aws_db_instance.db.endpoint}"
}
