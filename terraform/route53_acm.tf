
######################################
# Route53 host zone
######################################

data aws_route53_zone host_domain {
    name = local.host_domain
}

######################################
# Route53 sub domain
######################################

resource "aws_route53_zone" "app_subdomain" {
    name = local.app_domain_name
}

resource "aws_route53_zone" "api_subdomain" {
    name = local.api_domain_name
}

######################################
# Route53 NS record
######################################

resource "aws_route53_record" "ns_record_app_subdomain" {
    name    = aws_route53_zone.app_subdomain.name
    type    = "NS"
    zone_id = data.aws_route53_zone.host_domain.id
    records = [
        aws_route53_zone.app_subdomain.name_servers[0],
        aws_route53_zone.app_subdomain.name_servers[1],
        aws_route53_zone.app_subdomain.name_servers[2],
        aws_route53_zone.app_subdomain.name_servers[3],
    ]
    # 1日
    ttl = 86400 
}

resource "aws_route53_record" "ns_record_api_subdomain" {
    name    = aws_route53_zone.api_subdomain.name
    type    = "NS"
    zone_id = data.aws_route53_zone.host_domain.id
    records = [
        aws_route53_zone.api_subdomain.name_servers[0],
        aws_route53_zone.api_subdomain.name_servers[1],
        aws_route53_zone.api_subdomain.name_servers[2],
        aws_route53_zone.api_subdomain.name_servers[3],
    ]
    # 1日
    ttl = 86400 
}

######################################
# Route53 record ALB
######################################

resource "aws_route53_record" "a_record_for_app_subdomain" {
    zone_id = aws_route53_zone.app_subdomain.zone_id
    name    = aws_route53_zone.app_subdomain.name
    type    = "A"
    alias {
        name                   = aws_lb.this.dns_name
        zone_id                = aws_lb.this.zone_id
        evaluate_target_health = true
    }
}

resource "aws_route53_record" "a_record_for_api_subdomain" {
    zone_id = aws_route53_zone.api_subdomain.zone_id
    name    = aws_route53_zone.api_subdomain.name
    type    = "A"
    alias {
        name                   = aws_lb.this.dns_name
        zone_id                = aws_lb.this.zone_id
        evaluate_target_health = true
    }
}



######################################
# Inport ACM
######################################

data "aws_acm_certificate" "host_domain_acm" {
    # domain = "*.${local.host_domain}"
    domain = local.host_domain
}

######################################
# Route53 ACM create
######################################

# resource "aws_acm_certificate" "domain_acm" {
#     key_algorithm   = "RSA"
#     domain_name = "*.${local.host_domain}"
#     subject_alternative_names = [local.host_domain]

#     validation_method = "DNS"

#     lifecycle {
#     create_before_destroy = true
#     }
# }

# 検証用
# resource "aws_route53_record" "domain_acm_certificate" {
#     name = aws_acm_certificate.domain_acm.domain_vakudatuib_options[0].resource_record_name
#     type = aws_acm_certificate.domain_acm.domain_vakudatuib_options[0].resource_record_type
#     records = [aws_acm_certificate.domain_acm.domain_vakudatuib_options[0].resource_record_value]
#     zone_id = data.aws_route53_zone.host_domain.id
#     ttl = 60
# }

# 作成まで待機
# resource "aws_acm_certificate_validation" "this" {
#     certificate_arn = aws_acm_certificate.domain_acm.arn
#     validation_record_fqdns = [aws_route53_record.domain_acm_certificate.fqdns]
# }

