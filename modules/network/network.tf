# resource "aws_route" "internet_access" {
#   route_table_id         = aws_vpc.this.main_route_table_id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.this.id
# }

# #########
# resource "aws_vpc" "this" {
#   cidr_block = "10.0.0.0/16"
# }

# resource "aws_subnet" "this1" {
#   vpc_id     = aws_vpc.this.id
#   cidr_block = "10.0.1.0/24"
#   availability_zone = "us-east-1a"  # Spécifiez la zone de disponibilité ici

# }

# resource "aws_subnet" "this2" {
#   vpc_id     = aws_vpc.this.id
#   cidr_block = "10.0.2.0/24"
#   availability_zone = "us-east-1b"  # Spécifiez la zone de disponibilité ici

# }   


# resource "aws_internet_gateway" "this" {
#   vpc_id = aws_vpc.this.id
# }
# #########
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}


resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "this1" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"  

}

resource "aws_subnet" "this2" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"  

}   


resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
} 


