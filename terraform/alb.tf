######################################
# ALB
######################################

resource "aws_lb" "this" {
    name               = "${local.app_name}-alb"
    load_balancer_type = "application"
    security_groups = [
        aws_security_group.alb_sg.id
    ]
    subnets = [
        aws_subnet.public_1a.id,
        aws_subnet.public_1c.id
        # ,aws_subnet.public_1d.id,
    ]
    # access_logs = [
    #     bucket = ""
    #     enabled = true
    # ]
}

######################################
# ALB listener
######################################

resource "aws_lb_listener" "https" {
    load_balancer_arn = aws_lb.this.arn
    port              = "443"
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = data.aws_acm_certificate.host_domain_acm.arn
    default_action {
        type = "fixed-response"
        fixed_response {
            content_type = "text/plain"
            # message_body = "503 Service Temporarily Unavailable"
            message_body = "これは「HTTPS」です"
            status_code  = "503"
        }
    }
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.this.arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
        type = "redirect"
        redirect {
            port        = "443"
            protocol    = "HTTPS"
            status_code = "HTTP_301"
        }
    }
}

######################################
# ALB maintenance HTML
######################################

locals {
    maintenance_body = <<EOF
    <!doctype html> <title>メンテナンス中</title> <style> body { text-align: center; padding: 150px; } h1 { font-size: 50px; } body { font: 20px Helvetica, sans-serif; color: #333; } article { display: block; text-align: left; width: 650px; margin: 0 auto; } a { color: #dc8100; text-decoration: none; } a:hover { color: #333; text-decoration: none; } </style> <article> <h1>Sorry...<br>只今メンテナンス中です</h1> <div> <p>システムの改修を行なっております。ご不便をおかけいたしますが今しばらくお待ちください。</p> <p>&mdash; 開発チーム</p> </div> </article>
EOF
}

####################################################
# ALB listener (ECS on frontend)
####################################################

resource "aws_lb_target_group" "frontend" {
    name                 = "${local.app_name}-service-tg-frontend"
    vpc_id               = aws_vpc.this.id
    target_type          = "ip"
    port                 = "80"
    protocol             = "HTTP"
    deregistration_delay = "60"
    # add
    # depends_on = [aws_lb.this]
    # health_check { path = "/"}
    health_check {
        enabled             = true
        path                = "/"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 120
        interval            = 150
        matcher             = 200
    }
}

resource "aws_lb_listener_rule" "frontend" {
    listener_arn = aws_lb_listener.https.arn
    priority     = "1"
    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.frontend.arn
    }
    condition {
        host_header {
            values = [local.app_domain_name]
        }
    }
}

####################################################
# ALB listener (ECS on backend)
####################################################

resource "aws_lb_target_group" "backend" {
    name                 = "${local.app_name}-service-tg-backend"
    vpc_id               = aws_vpc.this.id
    target_type          = "ip"
    port                 = "80"
    protocol             = "HTTP"
    deregistration_delay = "60"
    # health_check { path = "/api/health_check" }
    health_check {
        enabled             = true
        path                = "/api/health_check"
        healthy_threshold   = 5
        unhealthy_threshold = 2
        timeout             = 50
        interval            = 60
        matcher             = 200
    }
    # add
    depends_on = [aws_lb.this]
}

resource "aws_lb_listener_rule" "backend" {
    listener_arn = aws_lb_listener.https.arn
    priority     = "2"
    action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.backend.arn
    }
    condition {
        host_header {
            values = [local.api_domain_name]
        }
    }
}

resource "aws_lb_listener_rule" "maintenance" {
    listener_arn = aws_lb_listener.https.arn
    priority     = "100"
    action {
        type = "fixed-response"
        fixed_response {
            content_type = "text/html"
            message_body = local.maintenance_body
            status_code = "503"
        }
    }
    condition {
        path_pattern {
            values = ["*"]
        }
    }
}