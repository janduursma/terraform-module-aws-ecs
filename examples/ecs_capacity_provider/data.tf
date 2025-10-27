data "aws_ami_ids" "demo" {
  owners = ["amazon"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
