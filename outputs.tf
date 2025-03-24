output "public_ip" {
  value = "The public ip is : ${aws_instance.example_server.public_ip}"
}