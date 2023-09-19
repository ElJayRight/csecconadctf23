
resource "aws_instance" "vpn-gateway" {
  ami           = "ami-0310483fb2b488153"  # Replace with your desired AMI ID
  instance_type = "t2.micro"               # Replace with your desired instance type
  key_name      = "terraform"     # Replace with your key pair name
  subnet_id = aws_subnet.publicsubnets.id
  vpc_security_group_ids = [aws_security_group.ssh_access.id]
  associate_public_ip_address = true
  private_ip = "172.100.31.22"

  tags = {
    Name = "vpn-gateway"
  }
}

resource "aws_security_group" "ssh_access" {
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
    cidr_blocks = ["58.179.7.18/32"]
    description = ""
    from_port   = 22
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol    = "tcp"
    security_groups = []
    self = false
    to_port     = 22
    },
    {
      cidr_blocks = ["58.179.7.18/32"]
      description = ""
      from_port   = 1194
      to_port     = 1194
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      protocol    = "udp"
      security_groups = []
      self = false
    }
  ]
}

output "instance_public" {
  value = aws_instance.vpn-gateway.public_ip
}