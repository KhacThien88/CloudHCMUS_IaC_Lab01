resource "aws_wafv2_web_acl" "alb_waf" {
  name        = "alb-waf-acl"
  description = "WAF for ALB"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "block-sql-injection"
    priority = 1

    action {
      block {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "blockSQLInjection"
      sampled_requests_enabled   = true
    }
  }
  

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "albWAF"
    sampled_requests_enabled   = true
  }
}
resource "aws_wafv2_web_acl_association" "alb_waf_association" {
  resource_arn = var.alb-arn
  web_acl_arn  = aws_wafv2_web_acl.alb_waf.arn
}

