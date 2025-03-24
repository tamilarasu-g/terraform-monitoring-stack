resource "aws_instance" "example_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "warhammer"

  network_interface {
    network_interface_id = aws_network_interface.test_primary_nic.id
    device_index         = 0
  }

  root_block_device {
    volume_size = 9
    volume_type = "gp3"
  }

  tags = {
    Name = "Testing"
  }

}

resource "aws_volume_attachment" "volume_attach" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.test_volume.id
  instance_id = aws_instance.example_server.id
}