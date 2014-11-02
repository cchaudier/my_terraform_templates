resource "aws_db_instance" "db" {
  identifier = "${var.aws_db_name}-pg-rds"
  
  #Type de la base
  engine = "postgres"
  engine_version = "9.3.3"
  
  #Taille
  instance_class = "db.t2.micro"
  allocated_storage = 5

  #Base de donnée à créer
  name = "${var.aws_db_name}"
  username = "${var.aws_db_username}"
  password = "${var.aws_db_password}"

  #Backup
  skip_final_snapshot = "true"

  #Securité
  publicly_accessible = "false"
  availability_zone = "${var.aws_zone.a}"
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.db_private_subnet.name}"
}
