variable "region" {
    type = string
    default = "us-east-2"
}

variable "vpcCidir" {
    type = string
    default = "10.0.0.0/16"
}

variable "PubsubnetCidir" {
    type = string
    default = "10.0.1.0/24"
}

variable "PubSubAZ" {
    type = string
    default = "us-east-2b"
}
variable "VpcName" {
    type = string
    default = "dev_vpc"
    }
       

variable "publicName" {
    type = string
    default = "public_sub"
  
}

variable "PrSubCidir" {
    type = string
    default = "10.0.2.0/24"
}

variable "prSubAz" {
    type = string
    default = "us-east-2a"
}

variable "PrSubName" {
    type = string
    default = "private_sub"
}
variable "GateWayCid" {
    type = string
    default = "0.0.0.0/0"
    
}
variable "RTName" {
    type = string
    default = "myrout-table"
  
}
variable "ec2AMI" {
    type = string
    default = "ami-024e6efaf93d85776"
  
}
variable "ec2instancetype" {
    type = string
    default = "t2.medium"
  
}
variable "mykeys" {
    type = string
    default = "terraform"
  
}