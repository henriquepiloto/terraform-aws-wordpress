output "alb_arn" {
  description = "ARN do Load Balancer"
  value       = aws_lb.wordpress_alb.arn
}

output "alb_dns_name" {
  description = "DNS do Load Balancer"
  value       = aws_lb.wordpress_alb.dns_name
}
