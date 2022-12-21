####################################################
# IAM role (ECS)
####################################################

resource "aws_iam_role" "ecs_task_execution_role" {
    name = "ecs_task_execution_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action    = "sts:AssumeRole"
                Effect    = "Allow"
                Principal = {
                    Service = "ecs-tasks.amazonaws.com"
                }
            },
        ]
    })
    managed_policy_arns = [
        "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
        "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
    ]
}

resource "aws_iam_role_policy" "kms_decrypt_policy" {
    name  = "${local.app_name}_ecs_task_execution_role_policy_kms"
    role  = aws_iam_role.ecs_task_execution_role.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                "Effect": "Allow",
                "Action": [
                    "kms:Decrypt"
                ],
                "Resource": [
                    data.aws_ssm_parameter.database_password.arn
                ]
            }
        ]
    })
    # add
    depends_on = [
        aws_ecs_service.frontend,
        aws_ecs_service.backend
        ]
}
