######################################
# Nat Gateway
######################################

resource "aws_nat_gateway" "this" {
    subnet_id     = aws_subnet.public_1a.id
    allocation_id = aws_eip.this.id
    tags = {
        Name = "${local.app_name}-natgw-1a"
    }
    depends_on = [aws_internet_gateway.this]
}
