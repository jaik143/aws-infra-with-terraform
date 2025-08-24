data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "my_instance" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
   key_name                = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  tags = {
    Name = var.instance_name
  }

  user_data = var.user_data

  lifecycle {
    ignore_changes = [ami]
  }
}

resource "aws_lb_target_group_attachment" "ec2_target" {

  target_group_arn = var.target_group_arn
  target_id        = aws_instance.my_instance.id
  port             = 80
}
