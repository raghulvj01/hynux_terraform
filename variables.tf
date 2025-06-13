variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Name for the EC2 key pair"
  type        = string
  default     = "my-singapore-key"
}

variable "public_key_file" {
  description = "Relative path to the public key file"
  type        = string
  default     = "id_rsa.pub"
}
