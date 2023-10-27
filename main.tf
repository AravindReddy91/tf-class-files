# VPC 
resource "aws_vpc" "aquila" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "aquila"
  }
}

# Public Subnet
resource "aws_subnet" "aquila_pub_sb" {
  vpc_id     = aws_vpc.aquila.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "aquila-PUB-SB"
  }
}

# Private Subnet
resource "aws_subnet" "aquila_pvt_sb" {
  vpc_id     = aws_vpc.aquila.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "aquila-PVT-SB"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "aquila_igw" {
  vpc_id = aws_vpc.aquila.id

  tags = {
    Name = "aquila-IGW"
  }
}

# Public Route Table
resource "aws_route_table" "aquila_pub_rt" {
  vpc_id = aws_vpc.aquila.id

  tags = {
    Name = "aquila-PUB-RT"
  }
}

output "aws_route_table_public_ids" {
  value = aws_route_table.aquila_pub_rt.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.aquila_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aquila_igw.id
}


# Private Route Table
# Default is private 
resource "aws_route_table" "aquila_pvt_rt" {
  vpc_id = aws_vpc.aquila.id

  tags = {
    Name = "aquila-PVT-RT"
  }
}

# Public Route Table Association
resource "aws_route_table_association" "aquila_pub_assoc" {
  subnet_id      = aws_subnet.aquila_pub_sb.id
  route_table_id = aws_route_table.aquila_pub_rt.id
}

# Private Route Table Association
resource "aws_route_table_association" "aquila_pvt_assoc" {
  subnet_id      = aws_subnet.aquila_pvt_sb.id
  route_table_id = aws_route_table.aquila_pvt_rt.id
}
