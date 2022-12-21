######################################
# Elastic IP
######################################

resource "aws_eip" "this" {
    vpc  = true
    tags = {
        Name = "${local.app_name}-eip"
    }
    depends_on = [aws_internet_gateway.this]
}