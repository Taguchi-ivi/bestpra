######################################
# public subnet
######################################

resource "aws_subnet" "public_1a" {
    vpc_id            = aws_vpc.this.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-northeast-1a"
    tags = {
        Name = "${local.app_name}-public-1a"
    }
}

resource "aws_subnet" "public_1c" {
    vpc_id            = aws_vpc.this.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = "ap-northeast-1c"
    tags = {
        Name = "${local.app_name}-public-1c"
    }
}

# resource "aws_subnet" "public_1d" {
#     vpc_id            = aws_vpc.this.id
#     cidr_block        = "10.0.3.0/24"
#     availability_zone = "ap-northeast-1d"
#     tags = {
#         Name = "${local.app_name}-public-1d"
#     }
# }

######################################
# private subnet
######################################

resource "aws_subnet" "private_1a" {
    vpc_id            = aws_vpc.this.id
    cidr_block        = "10.0.10.0/24"
    availability_zone = "ap-northeast-1a"
    tags = {
        Name = "${local.app_name}-private-1a"
    }
}

resource "aws_subnet" "private_1c" {
    vpc_id            = aws_vpc.this.id
    cidr_block        = "10.0.11.0/24"
    availability_zone = "ap-northeast-1c"
    tags = {
        Name = "${local.app_name}-private-1c"
    }
}

# resource "aws_subnet" "private_1d" {
#     vpc_id            = aws_vpc.this.id
#     cidr_block        = "10.0.12.0/24"
#     availability_zone = "ap-northeast-1d"
#     tags = {
#         Name = "${local.app_name}-private-1d"
#     }
# }

######################################
# subnet group (RDS)
######################################

resource "aws_db_subnet_group" "rds_sg_group" {
    name        = "${local.app_name}-rds-subnet-group"
    description = "${local.app_name}-rds-subnet-group"
    subnet_ids = [
        aws_subnet.private_1a.id,
        aws_subnet.private_1c.id
        # ,aws_subnet.private_1d.id,
    ]
}
