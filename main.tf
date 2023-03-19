provider "aws" {
  region = var.aws_region
}

resource "aws_default_vpc" "default_vpc" {
}

resource "aws_security_group" "cluster_sg" {
  name        = "cluster_sg"
  description = "allow all internal traffic, ssh, http and https from anywhere"
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = "true"
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9411
    to_port     = 9411
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 30005
    to_port     = 30005
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 30007
    to_port     = 30007
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 31601
    to_port     = 31601
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "master" {
  instance_type   = var.master_instance_type
  ami             = data.aws_ami.ubuntu.id
  user_data       = "master.tpl"
  key_name        = var.key_name
  security_groups = ["${aws_security_group.cluster_sg.name}"]
  tags = {
    Name = "master"
  }
}
#

resource "aws_instance" "node" {
  instance_type   = var.node_instance_type
  count           = var.node_count
  ami             = data.aws_ami.ubuntu.id
  user_data       = "node.tpl"
  key_name        = var.key_name
  security_groups = ["${aws_security_group.cluster_sg.name}"]
  tags = {
    Name = "node"
  }
}
 #

#resource "aws_elb" "my-elb" {
  depends_on = [aws_instance.node]
  name       = "my-elb"
  subnets    = var.subnet
  #instances  = ["${"aws_instance.node.*.id"}"]
  #availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c","us-east-1d", "us-east-1e", "us-east-1f"]
  security_groups = ["${aws_security_group.cluster_sg.id}"]
  listener {
    lb_port           = 80
    instance_port     = 30001
    lb_protocol       = "http"
    instance_protocol = "http"
  }

  listener {
    lb_port           = 9411
    instance_port     = 30002
    lb_protocol       = "http"
    instance_protocol = "http"
  }

#}
