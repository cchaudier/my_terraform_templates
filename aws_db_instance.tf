resource "aws_db_instance" "db" {
  identifier = "mydb-rds"
  
  #Type de la base
  engine = "postgres"
  engine_version = "9.3.3"
  
  #Taille
  #instance_class = "db.t1.micro"
  instance_class = "db.t2.micro"
  allocated_storage = 5

  #Base de donnée à créer
  name = "mydb"
  username = "admin_ccr"
  password = "admin_ccr"

  #Backup

  #Securité
  publicly_accessible = "false"
  #security_group_names = ["${aws_db_security_group.db_sg.name}"]
}
