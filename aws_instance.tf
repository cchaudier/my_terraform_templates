resource "aws_instance" "web" {

  instance_type = "${var.aws_instance_type}"
  ami = "${var.aws_ami}"
  key_name = "${var.aws_key_name}"

  # Our Security group to allow HTTP and SSH access
  depends_on = [ 
    "aws_security_group.web_sg" 
  ]
  security_groups = [
    "${aws_security_group.web_sg.id}"
  ]
  subnet_id = "${aws_subnet.publique_subnet.id}"

  # We run a local provisioner on the instance after creating it.
  #provisioner "local-exec" {
    #command = "cd ansible; sleep 300; ansible-playbook --extra-vars \"target=${aws_instance.web.public_ip}\" pb_django.yml --user ubuntu"
  #}
}
