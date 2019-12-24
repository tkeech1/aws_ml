output "group_name" {
  value       = local.log_group_name
  description = "Name of the log group"
}
output "stream_name" {
  value       = local.log_stream_name
  description = "Name of the log stream"
}
