resource "aws_ebs_volume" "test_volume" {
  availability_zone = aws_subnet.test_subnet.availability_zone
  size = 9

  tags = merge(local.common_tags,{
    Name = "test_volume"
    dev = "true"
  })
}