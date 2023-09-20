resource "aws_instance" "vpn-gateway" {
  ami                           = "ami-0310483fb2b488153"  
  instance_type                 = "t2.micro"               
  private_ip                     = "172.100.31.69"
  subnet_id                     = aws_subnet.publicsubnets.id
  vpc_security_group_ids        = [aws_security_group.ssh_access.id]
  key_name                      = "terraform"
  associate_public_ip_address   = true


  tags = {
    Name = "vpn-gateway"
  }
}

resource "aws_instance" "parent-dc" {
  ami                           = "ami-0bcf9688fa5e01340"  
  instance_type                 = "t2.micro"
  private_ip                    = "172.100.31.204"
  subnet_id                     = aws_subnet.publicsubnets.id  
  vpc_security_group_ids        = [aws_security_group.windows_ports.id]
  associate_public_ip_address   = true

  tags = {
    Name = "Parent-dc"
  }

  user_data = file("./windowshelper.ps1")
}

resource "aws_instance" "Child-dc" {
  ami                           = "ami-0bcf9688fa5e01340"  
  instance_type                 = "t2.micro"
  private_ip                    = "172.100.31.152"
  subnet_id                     = aws_subnet.publicsubnets.id  
  vpc_security_group_ids        = [aws_security_group.windows_ports.id]
  associate_public_ip_address   = true

  tags = {
    Name = "Child-dc"
  }

  user_data = file("./windowshelper.ps1")

}

resource "aws_instance" "Client01" {
  ami                           = "ami-0bcf9688fa5e01340"  
  instance_type                 = "t2.micro"
  private_ip                    = "172.100.31.221"
  subnet_id                     = aws_subnet.publicsubnets.id  
  vpc_security_group_ids        = [aws_security_group.windows_ports.id]
  associate_public_ip_address   = true

  tags = {
    Name = "Client01"
  }

  user_data = file("./windowshelper.ps1")

}

resource "aws_instance" "Client02" {
  ami                           = "ami-0bcf9688fa5e01340"  
  instance_type                 = "t2.micro"
  private_ip                    = "172.100.31.249"
  subnet_id                     = aws_subnet.publicsubnets.id  
  vpc_security_group_ids        = [aws_security_group.windows_ports.id]
  associate_public_ip_address   = true

  tags = {
    Name = "Client02"
  }

  user_data = file("./windowshelper.ps1")

}

output "Parent-dc-ip" {
  value = aws_instance.parent-dc.public_ip
}
output "Child-dc-ip" {
  value = aws_instance.Child-dc.public_ip
}
output "Client01-ip" {
  value = aws_instance.Client01.public_ip
}
output "Client02-ip" {
  value = aws_instance.Client02.public_ip
}
output "vpn-ip" {
  value = aws_instance.vpn-gateway.public_ip
}