output "instance_ip" {
  description = "Public IP of the Hynux EC2 instance"
  value       = aws_eip.static_ip.public_ip
}
