
####################################################
# Cloudwatch logs group (ECS task container)
####################################################

resource "aws_cloudwatch_log_group" "frontend" {
    name              = "/ecs/${local.app_name}/frontend"
    retention_in_days = "30"
}

resource "aws_cloudwatch_log_group" "backend_middleware" {
    name              = "/ecs/${local.app_name}/backend/middleware"
    retention_in_days = "30"
}

resource "aws_cloudwatch_log_group" "backend_app" {
    name              = "/ecs/${local.app_name}/backend/app"
    retention_in_days = "30"
}
