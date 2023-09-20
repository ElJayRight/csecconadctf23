data "external" "myipaddr" {
  program = ["bash", "-c", "curl -s 'https://ipinfo.io/json'"]
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
    cidr_blocks = ["${data.external.myipaddr.result.ip}/32"]
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
      cidr_blocks = ["${data.external.myipaddr.result.ip}/32"]
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
resource "aws_security_group" "windows_ports" {
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
    cidr_blocks = ["${data.external.myipaddr.result.ip}/32"]
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
    cidr_blocks = ["${data.external.myipaddr.result.ip}/32"]
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