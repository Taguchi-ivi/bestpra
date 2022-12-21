
terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = ">= 4.1.0"
        }
    }
}

locals {
    app_name                 = "bestpra"
    host_domain              = "best-pra.com"
    app_domain_name          = "app.best-pra.com"
    api_domain_name          = "api.best-pra.com"
    ssm_parameter_store_base = "/bestpra/prod"
}

provider "aws" {
    region = "ap-northeast-1"
    default_tags {
        tags = {
            application = local.app_name
        }
    }
}

