provider "aws" {
    region = var.region
}

resource "aws_vpc" "myvpc" {
    cidr_block = var.vpcCidir
    tags = {
      Name = "dev_vpc"
    }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_subnet" "public-sub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.PubsubnetCidir
  availability_zone = var.PubSubAZ
  tags = {
    Name = var.publicName
  }
}

resource "aws_subnet" "Private_sub" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.PrSubCidir
  availability_zone = var.prSubAz
  tags = {
    Name = var.PrSubName
  }
}
resource "aws_route_table" "mypubRT" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = var.GateWayCid
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = var.RTName
  }

}
resource "aws_route_table_association" "pubblic" {
    subnet_id = aws_subnet.public-sub.id
    route_table_id = aws_route_table.mypubRT.id
}


resource "aws_instance" "app" {
    ami = var.ec2AMI
    instance_type = var.ec2instancetype
    subnet_id = aws_subnet.public-sub.id
    vpc_security_group_ids = [
      aws_security_group.mysg.id, 
      aws_security_group.myjenkinssg.id]
    user_data = ("jenkinstallation.sh")
    associate_public_ip_address = true
    key_name = var.mykeys
    tags = {
      Name = "jenkins-server"
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

