
locals {
    frontend_task_name                     = "${local.app_name}-app-task-frontend"
    backend_task_name                      = "${local.app_name}-app-task-backend"
    frontend_task_container_name           = "${local.app_name}-app-container-frontend"
    backend_task_middleware_container_name = "${local.app_name}-app-container-nginx-backend"
    backend_task_app_container_name        = "${local.app_name}-app-container-rails-backend"
}

data "aws_ssm_parameter" "app_env" {
    name = "${local.ssm_parameter_store_base}/app_env"
}

data "aws_ssm_parameter" "app_key" {
    name = "${local.ssm_parameter_store_base}/app_key"
}

data "aws_ssm_parameter" "access_key" {
    name = "${local.ssm_parameter_store_base}/access_key"
}

data "aws_ssm_parameter" "secret_access_key" {
    name = "${local.ssm_parameter_store_base}/secret_access_key"
}

data "aws_ssm_parameter" "base_url" {
    name = "${local.ssm_parameter_store_base}/base_url"
}

data "aws_ssm_parameter" "cookies_same_site" {
    name = "${local.ssm_parameter_store_base}/cookies_same_site"
}


####################################################
# ECS cluster
####################################################

resource "aws_ecs_cluster" "this" {
    name = "${local.app_name}-app-ecs-cluster"

    setting {
        name  = "containerInsights"
        value = "enabled"
    }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
    cluster_name       = aws_ecs_cluster.this.name
    capacity_providers = ["FARGATE"]

    default_capacity_provider_strategy {
        base              = 1
        weight            = 100
        capacity_provider = "FARGATE"
    }
}

####################################################
# ECS Task Definition
####################################################

resource "aws_ecs_task_definition" "frontend" {
    family                   = local.frontend_task_name
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    cpu                      = "512"
    memory                   = "1024"
    execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
    task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
    container_definitions    = jsonencode([
        {
            name             = local.frontend_task_container_name
            image            = "${data.aws_ecr_repository.frontend.repository_url}:${local.ecr_frontend_repository_newest_tags[0]}"
            portMappings     = [{ containerPort : 3000 }]
            logConfiguration = {
                logDriver    = "awslogs"
                options = {
                    awslogs-group : aws_cloudwatch_log_group.frontend.name
                    awslogs-region : "ap-northeast-1"
                    awslogs-stream-prefix : "ecs"
                }
            }
        }
    ])
}

    # enable_execute_command   = true
resource "aws_ecs_task_definition" "backend" {
    family                   = local.backend_task_name
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    cpu                      = "256"
    memory                   = "512"
    execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
    task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
    container_definitions    = jsonencode([
        {
            name         = local.backend_task_middleware_container_name
            image        = "${data.aws_ecr_repository.backend_middleware.repository_url}:${local.ecr_backend_middleware_repository_newest_tags[0]}"
            portMappings = [{ containerPort : 80 }]
            volumesFrom  = [{
                sourceContainer: local.backend_task_app_container_name
                # readOnly: null
            }]
            dependsOn    = [{
                containerName: local.backend_task_app_container_name
                condition: "START"
            }]
            logConfiguration = {
                logDriver = "awslogs"
                options   = {
                    awslogs-group : aws_cloudwatch_log_group.backend_middleware.name
                    awslogs-region : "ap-northeast-1"
                    awslogs-stream-prefix : "ecs"
                }
            }
        },
        {
            name    = local.backend_task_app_container_name
            image   = "${data.aws_ecr_repository.backend_app.repository_url}:${local.ecr_backend_app_repository_newest_tags[0]}"
            secrets = [
                {
                    name: "APP_ENV"
                    valueFrom: data.aws_ssm_parameter.app_env.arn
                },
                {
                    name: "RAILS_MASTER_KEY"
                    valueFrom: data.aws_ssm_parameter.app_key.arn
                },
                {
                    name: "AWS_ACCESS_KEY_ID"
                    valueFrom: data.aws_ssm_parameter.access_key.arn
                },
                {
                    name: "AWS_SECRET_ACCESS_KEY"
                    valueFrom: data.aws_ssm_parameter.secret_access_key.arn
                },
                {
                    name: "BASE_URL"
                    valueFrom: data.aws_ssm_parameter.base_url.arn
                },
                {
                    name: "DB_DATABASE"
                    valueFrom: data.aws_ssm_parameter.database_name.arn
                },
                {
                    name: "DB_USERNAME"
                    valueFrom: data.aws_ssm_parameter.database_user.arn
                },
                {
                    name: "DB_PASSWORD"
                    valueFrom: data.aws_ssm_parameter.database_password.arn
                },
                {
                    name: "DB_HOST"
                    valueFrom: aws_ssm_parameter.database_url.arn
                },
                {
                    name: "COOKIES_SAME_SITE"
                    valueFrom: data.aws_ssm_parameter.cookies_same_site.arn
                }
            ]
            logConfiguration = {
                logDriver = "awslogs"
                options   = {
                    awslogs-region : "ap-northeast-1"
                    awslogs-group : aws_cloudwatch_log_group.backend_app.name
                    awslogs-stream-prefix : "ecs"
                }
            }
        }
    ])

}

####################################################
# ECS Cluster Service
####################################################

resource "aws_ecs_service" "frontend" {
    name                               = "${local.app_name}-frontend"
    cluster                            = aws_ecs_cluster.this.id
    platform_version                   = "LATEST"
    task_definition                    = aws_ecs_task_definition.frontend.arn
    desired_count                      = "1"
    deployment_minimum_healthy_percent = "100"
    deployment_maximum_percent         = "200"
    propagate_tags                     = "SERVICE"
    enable_execute_command             = true
    launch_type                        = "FARGATE"
    health_check_grace_period_seconds  = "60"
    deployment_circuit_breaker {
        enable   = true
        rollback = true
    }
    network_configuration {
        assign_public_ip = true
        subnets = [
            aws_subnet.public_1a.id
        ]
        security_groups = [
            aws_security_group.app.id
        ]
    }
    load_balancer {
        target_group_arn = aws_lb_target_group.frontend.arn
        container_name   = local.frontend_task_container_name
        container_port   = "3000"
    }
}

resource "aws_ecs_service" "backend" {
    name                               = "${local.app_name}-backend"
    cluster                            = aws_ecs_cluster.this.id
    platform_version                   = "LATEST"
    task_definition                    = aws_ecs_task_definition.backend.arn
    desired_count                      = "1"
    deployment_minimum_healthy_percent = "100"
    deployment_maximum_percent         = "200"
    propagate_tags                     = "SERVICE"
    enable_execute_command             = true
    launch_type                        = "FARGATE"
    health_check_grace_period_seconds  = "60"
    deployment_circuit_breaker {
        enable   = true
        rollback = true
    }
    network_configuration {
        assign_public_ip = true
        subnets = [
            aws_subnet.public_1c.id
        ]
        security_groups = [
            aws_security_group.app.id
        ]
    }
    load_balancer {
        target_group_arn = aws_lb_target_group.backend.arn
        container_name   = local.backend_task_middleware_container_name
        container_port   = "80"
    }
}

