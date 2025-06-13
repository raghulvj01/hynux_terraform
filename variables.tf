variable "region" {
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "key_name" {
  description = "The name of the SSH key pair in AWS"
  type        = string
}
