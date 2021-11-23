data "aws_cloudwatch_event_source" "partner_source" {
  count = length(var.partner_source) != 0 ? 1 : 0
  name_prefix = var.partner_source
}

resource "aws_cloudwatch_event_bus" "event_bus" {
  name = length(var.partner_source) != 0 ? data.aws_cloudwatch_event_source.partner_source[0].name : var.name
  event_source_name = length(var.partner_source) != 0 ? data.aws_cloudwatch_event_source.partner_source[0].name : null
}

resource "aws_cloudwatch_event_archive" "eb_archive" {
  count = var.create_archive ? 1 : 0
  name = format("%s-archive", var.name)
  description = try(length(var.description), 0) != 0 ? var.description : null
  retention_days = var.retention_days
  
  event_source_arn = aws_cloudwatch_event_bus.event_bus.arn
  event_pattern = var.event_pattern == {} ? null : jsonencode(var.event_pattern)
}