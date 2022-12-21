#######################################
# public subnet routeTable
#######################################

resource "aws_route_table" "public_rtb" {
    vpc_id = aws_vpc.this.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.this.id
    }
    tags = {
        Name = "${local.app_name}-public-rtb"
    }
}

#######################################
# public subnet routeTable Assciation
#######################################

resource "aws_route_table_association" "public1a_to_ig" {
    subnet_id      = aws_subnet.public_1a.id
    route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "public1c_to_ig" {
    subnet_id      = aws_subnet.public_1c.id
    route_table_id = aws_route_table.public_rtb.id
}

# resource "aws_route_table_association" "public1d_to_ig" {
#     subnet_id      = aws_subnet.public_1d.id
#     route_table_id = aws_route_table.public_rtb.id
# }

#######################################
# private subnet routeTable
#######################################

resource "aws_route_table" "private_1a" {
    vpc_id = aws_vpc.this.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.this.id
    }
    tags = {
        Name ="${local.app_name}-private-rtb"
    }
}

#######################################
# private subnet routeTable Assciation
#######################################

resource "aws_route_table_association" "private_1a" {
    subnet_id      = aws_subnet.private_1a.id
    route_table_id = aws_route_table.private_1a.id
}