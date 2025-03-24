resource "aws_instance" "example_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "warhammer"

  network_interface {
    network_interface_id = aws_network_interface.test_primary_nic.id
    device_index = 0
  }

  tags = {
    Name = "Testing"
  }

}