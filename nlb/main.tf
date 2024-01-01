locals {
  access_logs_enabled = var.enable_access_logs ? [1] : []
  s3_bucket_count     = var.enable_access_logs && var.auto_create_s3_log_bucket ? 1 : 0
  access_logs_bucket  = var.enable_access_logs ? var.nlb_access_log_bucket_name : null
}

resource "aws_lb" "this" {
  name                              = var.name
  internal                          = var.is_internal
  load_balancer_type                = var.lb_type
  subnets                           = var.subnet_ids
  enable_cross_zone_load_balancing  = var.is_enable_cross_zone_load_balancing
  enable_deletion_protection        = var.is_deletion_protected

  dynamic "access_logs" {
    for_each = local.access_logs_enabled
    content {
      bucket  = local.access_logs_bucket
      prefix  = "nlb-${var.name}"
      enabled = var.enable_access_logs
    }
  }

    tags = merge(var.default_tags)

}


// nlb logs bucket
resource "aws_s3_bucket" "this" {
  count  = local.s3_bucket_count
  bucket = var.nlb_access_log_bucket_name
}
