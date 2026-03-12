provider "aws" {
   region = var.aws_region
}




data "aws_ami" "ubuntu" {

  most_recent = true 

  filter {
    name = "name"
    values = [var.ubuntu_ami_name]
  }

    owners = [var.ubuntu_ami_owner]
}




resource "aws_security_group" "boris_security_group" {
    name = "boris_security_group"
    vpc_id = var.vpc_id

}



resource "aws_vpc_security_group_ingress_rule" "allow_http" {
    security_group_id = aws_security_group.boris_security_group.id
    from_port = "80"
    to_port = "80"
    ip_protocol = "http"
    cidr_ipv4 = "0.0.0.0/0"
}


resource "aws_vpc_security_group_ingress_rule" "allow_icmp" {
    ip_protocol = "icmp"
    cidr_ipv4 = "0.0.0.0/0"
    security_group_id = aws_security_group.boris_security_group.id
}


resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
    from_port = "22"
    to_port = "22"
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
    security_group_id = aws_security_group.boris_security_group.id
}


resource "aws_vpc_security_group_egress_rule" "allow_all" {
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
    security_group_id = aws_instance.boris_security_group.id
}

resource "aws_subnet" "boris_subnet" {
    vpc_id = var.vpc_id
    cidr_block = "172.31.20.0/24"

}

resource "aws_key_pair" "boris_keypair" {
   key_name = "boris_key"
   public_key = var.my_public_key
}


resource "aws_instance" "boris_instance" {  
    
    security_groups = [ aws_security_group.boris_security_group.id ]
    subnet_id = aws_subnet.boris_subnet.id
    associate_public_ip_address = true
    ami = data.aws_ami.ubuntu.id

    tags = {
        Name = "boris_instance"
    }
}




