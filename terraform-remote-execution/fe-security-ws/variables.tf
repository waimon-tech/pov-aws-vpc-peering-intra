variable "region" {
  description = "The region where the resources are created."
  default     = "ap-northeast-2"
}

variable "frontend_prefix" {
  description = "The prefix for the frontend resources."
  default     = "frontend"
}

variable "frontend_private_subnet_cidr" {
  description = "The CIDR block for the frontend private subnets."
  default     = ["10.0.253.0/24", "10.0.254.0/24", "10.0.255.0/24"]
}

variable "backend_private_subnet_cidr" {
  description = "The CIDR block for the backend private subnets."
  default     = ["192.168.253.0/24", "192.168.254.0/24", "192.168.255.0/24"]
}