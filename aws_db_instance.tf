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

  #Securité
  publicly_accessible = "false"
  #security_group_names = ["${aws_db_security_group.db_sg.name}"]
}
