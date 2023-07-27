/*output "publicIP" {
    value = aws_instance.app.public_ip
}*/


output "vpcName" {
    value = aws_vpc.myvpc.tags.Name
  
}