resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  # user data
  user_data = data.cloudinit_config.cloudinit-example.rendered
}
# create a 1GB EBS volume in the same AZ as the EC2 instance
resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "us-east-1a"
  size              = 1
  type              = "gp3"
  iops = 3000
  throughput = 125
  tags = {
    Name = "extra volume data"
  }
}


# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name  = var.INSTANCE_DEVICE_NAME
  volume_id    = aws_ebs_volume.ebs-volume-1.id
  instance_id  = aws_instance.example.id
  skip_destroy = true                            # skip destroy to avoid issues with terraform destroy
}



