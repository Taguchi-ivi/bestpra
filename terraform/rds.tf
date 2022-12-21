######################################
# RDS parameter
######################################

resource "aws_db_parameter_group" "this" {
    name   = "${local.app_name}-rds-parameter"
    family = "mysql8.0"

    parameter {
        name  = "character_set_database"
        value = "utf8mb4"
    }

    parameter {
        name  = "character_set_server"
        value = "utf8mb4"
    }
}

######################################
# RDS instance
######################################

resource "aws_db_instance" "this" {
    identifier              = "${local.app_name}-rds-instance"
    db_name                 = data.aws_ssm_parameter.database_name.value
    engine                  = "mysql"
    engine_version          = "8.0.31"
    instance_class          = "db.t3.micro"
    allocated_storage       = "30"
    max_allocated_storage   = "100"
    storage_type            = "gp2"
    username                = data.aws_ssm_parameter.database_user.value
    password                = data.aws_ssm_parameter.database_password.value
    backup_window           = "09:10-09:40"
    backup_retention_period = "10"
    maintenance_window      = "mon:10:10-mon:10:40"
    vpc_security_group_ids  = [aws_security_group.rds_sg.id]
    parameter_group_name    = aws_db_parameter_group.this.name
    db_subnet_group_name    = aws_db_subnet_group.rds_sg_group.name
    skip_final_snapshot     = true
}