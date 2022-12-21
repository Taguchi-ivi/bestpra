######################################
# VPC
######################################

resource "aws_vpc" "this" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${local.app_name}-vpc"
    }
}

