output "db_address" {
  value = "${aws_db_instance.db.adresse}"
}

output "db_endpoint" {
  value = "${aws_db_instance.db.endpoint}"
}

output "web_public_ip" {
  value = "${aws_instance.web.public_ip}"
}

output "web_public_dns_name" {
  value = "${aws_instance.web.public_dns}"
}

output "elastic_public_ip" {
  value = "${aws_eip.web_ip.public_ip}"
}
