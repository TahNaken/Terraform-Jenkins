resource "aws_instance" "app" {
    ami = "ami-053b0d53c279acc90"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public-sub.id
    vpc_security_group_ids = [
      aws_security_group.mysg.id, 
      aws_security_group.myjenkinssg.id]
    user_data = ("jenkinstallation.sh")
    associate_public_ip_address = true
    count = 2
    key_name = "ec2_keys"
    tags = {
      Name = "jenkins-server${count.index + 1}"
    }
}


resource "aws_security_group" "mysg" {
  name        = "ssh"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-SG"
  }
}

resource "aws_security_group" "myjenkinssg" {
  name        = "jenkinsSG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-SsG"
  }
}

