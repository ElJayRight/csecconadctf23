#server: ami-0bcf9688fa5e01340
#provider "aws" {
#  region = "ap-southeast-2"  # Update with your desired region
#  profile = "terraform"
#}

resource "aws_instance" "parent-dc" {
  ami           = "ami-0bcf9688fa5e01340"  # Replace with a Windows 10 AMI ID
  instance_type = "t2.micro"
  private_ip = "172.100.31.204"
  subnet_id     = aws_subnet.publicsubnets.id  # Replace with the desired subnet ID
  vpc_security_group_ids = [aws_security_group.winrm_inbound.id]
  associate_public_ip_address = true

  tags = {
    Name = "Parent-dc"
  }

  user_data = file("/home/eljay/adctf/terraform/windowshelper.ps1")
}

resource "aws_instance" "Child-dc" {
  ami           = "ami-0bcf9688fa5e01340"  # Replace with a Windows 10 AMI ID
  instance_type = "t2.micro"
  private_ip = "172.100.31.152"
  subnet_id     = aws_subnet.publicsubnets.id  # Replace with the desired subnet ID
  vpc_security_group_ids = [aws_security_group.winrm_inbound.id]
  associate_public_ip_address = true

  tags = {
    Name = "Child-dc"
  }

  user_data = file("/home/eljay/adctf/terraform/windowshelper.ps1")

}

resource "aws_instance" "Client01" {
  ami           = "ami-0bcf9688fa5e01340"  # Replace with a Windows 10 AMI ID
  instance_type = "t2.micro"
  private_ip = "172.100.31.221"
  subnet_id     = aws_subnet.publicsubnets.id  # Replace with the desired subnet ID
  vpc_security_group_ids = [aws_security_group.winrm_inbound.id]
  associate_public_ip_address = true

  tags = {
    Name = "Client01"
  }

  user_data = file("/home/eljay/adctf/terraform/windowshelper.ps1")

}

resource "aws_instance" "Client02" {
  ami           = "ami-0bcf9688fa5e01340"  # Replace with a Windows 10 AMI ID
  instance_type = "t2.micro"
  private_ip = "172.100.31.249"
  subnet_id     = aws_subnet.publicsubnets.id  # Replace with the desired subnet ID
  vpc_security_group_ids = [aws_security_group.winrm_inbound.id]
  associate_public_ip_address = true

  tags = {
    Name = "Client02"
  }

  user_data = file("/home/eljay/adctf/terraform/windowshelper.ps1")

}
resource "aws_security_group" "winrm_inbound" {
  vpc_id = aws_vpc.Main.id
  egress = [
    {
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
    from_port = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "-1"
    security_groups = []
    self = false
    to_port = 0
    }
  ]
  ingress = [
    {
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
    from_port   = 5985
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol    = "tcp"
    security_groups = []
    self = false
    to_port     = 5985
    },
        {
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
    from_port   = 5986
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol    = "tcp"
    security_groups = []
    self = false
    to_port     = 5986
    },
    {
    cidr_blocks = ["172.100.31.0/24"]
    description = ""
    from_port   = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol    = "-1"
    security_groups = []
    self = false
    to_port     = 0
    }
  ]
}
output "Parent-dc-ip" {
  value = aws_instance.parent-dc.private_ip
}
output "Child-dc-ip" {
  value = aws_instance.Child-dc.private_ip
}
output "Client01-ip" {
  value = aws_instance.Client01.private_ip
}
output "Client02-ip" {
  value = aws_instance.Client02.private_ip
}
