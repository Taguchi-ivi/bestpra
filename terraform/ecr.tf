
locals {
    ecr_frontend_repository_name           = "bestpra/frontend"
    ecr_backend_middleware_repository_name = "bestpra/backend-nginx"
    ecr_backend_app_repository_name        = "bestpra/backend-rails"
}

####################################################
# ECR data
####################################################

data "external" "ecr_image_frontend_newest" {
    program = [
        "aws", "ecr", "describe-images",
        "--repository-name", local.ecr_frontend_repository_name,
        "--query", "{\"tags\": to_string(sort_by(imageDetails,& imagePushedAt)[-1].imageTags)}",
    ]
}

locals {
    ecr_frontend_repository_newest_tags = jsondecode(data.external.ecr_image_frontend_newest.result.tags)
}

data "external" "ecr_image_backend_middleware_newest" {
    program = [
        "aws", "ecr", "describe-images",
        "--repository-name", local.ecr_backend_middleware_repository_name,
        "--query", "{\"tags\": to_string(sort_by(imageDetails,& imagePushedAt)[-1].imageTags)}",
    ]
}

locals {
    ecr_backend_middleware_repository_newest_tags = jsondecode(data.external.ecr_image_backend_middleware_newest.result.tags)
}

data "external" "ecr_image_backend_app_newest" {
    program = [
        "aws", "ecr", "describe-images",
        "--repository-name", local.ecr_backend_app_repository_name,
        "--query", "{\"tags\": to_string(sort_by(imageDetails,& imagePushedAt)[-1].imageTags)}",
    ]
}

locals {
    ecr_backend_app_repository_newest_tags = jsondecode(data.external.ecr_image_backend_app_newest.result.tags)
}

####################################################
# ECR repository input
####################################################

data "aws_ecr_repository" "frontend" {
    name = local.ecr_frontend_repository_name
}

data "aws_ecr_repository" "backend_middleware" {
    name = local.ecr_backend_middleware_repository_name
}

data "aws_ecr_repository" "backend_app" {
    name = local.ecr_backend_app_repository_name
}


####################################################
# ECR repository
####################################################

# resource "aws_ecr_repository" "ecr_frontend" {
#     name                 = local.ecr_frontend_repository_name
#     image_tag_mutability = "MUTABLE"

#     image_scanning_configuration {
#         scan_on_push = true
#     }
# }

# resource "aws_ecr_repository" "ecr_backend_nginx" {
#     name                 = local.ecr_backend_middleware_repository_name
#     image_tag_mutability = "MUTABLE"

#     image_scanning_configuration {
#         scan_on_push = true
#     }
# }

# resource "aws_ecr_repository" "ecr_backend_rails" {
#     name                 = local.ecr_backend_app_repository_name
#     image_tag_mutability = "MUTABLE"

#     image_scanning_configuration {
#         scan_on_push = true
#     }
# }

# ####################################################
# # ECR lifecycle policy
# ####################################################

# resource "aws_ecr_lifecycle_policy" "ecr_frontend_lp" {
#     repository = aws_ecr_repository.ecr_frontend.name

#     policy = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Expire images older than 14 days",
#             "selection": {
#                 "tagStatus": "untagged",
#                 "countType": "sinceImagePushed",
#                 "countUnit": "days",
#                 "countNumber": 14
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# }

# resource "aws_ecr_lifecycle_policy" "ecr_backend_nginx_lp" {
#     repository = aws_ecr_repository.ecr_backend_nginx.name

#     policy = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Expire images older than 14 days",
#             "selection": {
#                 "tagStatus": "untagged",
#                 "countType": "sinceImagePushed",
#                 "countUnit": "days",
#                 "countNumber": 14
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# }
# resource "aws_ecr_lifecycle_policy" "ecr_backend_rails_lp" {
#     repository = aws_ecr_repository.ecr_backend_rails.name

#     policy = <<EOF
# {
#     "rules": [
#         {
#             "rulePriority": 1,
#             "description": "Expire images older than 14 days",
#             "selection": {
#                 "tagStatus": "untagged",
#                 "countType": "sinceImagePushed",
#                 "countUnit": "days",
#                 "countNumber": 14
#             },
#             "action": {
#                 "type": "expire"
#             }
#         }
#     ]
# }
# EOF
# }