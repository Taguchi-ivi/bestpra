######################################
# Security group (ALB)
######################################

resource "aws_security_group" "alb_sg" {
    name   = "${local.app_name}-sg-alb"
    vpc_id = aws_vpc.this.id
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${local.app_name}-sg-alb"
    }
}

######################################
# Security group Rule (ALB)
######################################

resource "aws_security_group_rule" "alb_http" {
    type              = "ingress"
    from_port         = "80"
    to_port           = "80"
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "alb_https" {
    type              = "ingress"
    from_port         = "443"
    to_port           = "443"
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.alb_sg.id
}

######################################
# Security group (App)
######################################

resource "aws_security_group" "app" {
    name        = "${local.app_name}-app-sg"
    description = "security group for app"
    vpc_id      = aws_vpc.this.id
    tags = {
        Name = "${local.app_name}-app-sg"
    }
}

######################################
# Security group Rule (App)
######################################

resource "aws_security_group_rule" "app_from_this" {
    type              = "ingress"
    description       = "Allow from this"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    self              = true
    security_group_id = aws_security_group.app.id
}

resource "aws_security_group_rule" "app_from_alb" {
    type                     = "ingress"
    description              = "Alow from ALB"
    from_port                = 0
    to_port                  = 0
    protocol                 = "-1"
    security_group_id        = aws_security_group.app.id
    source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "app_to_any" {
    type              = "egress"
    description       = "Alow to any"
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.app.id
}

######################################
# Security group (RDS)
######################################

resource "aws_security_group" "rds_sg" {
    name        = "${local.app_name}-rds-sg"
    description = "${local.app_name}-rds-sg"
    vpc_id      = aws_vpc.this.id

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${local.app_name}-rds-sg"
    }
}

resource "aws_security_group_rule" "rds_sg_rule" {
    type                     = "ingress"
    from_port                = "3306"
    to_port                  = "3306"
    protocol                 = "tcp"
    security_group_id        = aws_security_group.rds_sg.id
    source_security_group_id = aws_security_group.app.id
}