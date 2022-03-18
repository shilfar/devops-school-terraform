variable "owner" {
  description = "Owner email"
  type        = string
  default     = "Ildar_Sharafeev@epam.com"
}

variable "user" {
  description = "DB User"
  type        = string
  default     = "testuser"
}

variable "password" {
  description = "DB password"
  type        = string
  default     = "superpassword"
}

variable "ssh_key_name" {
  description = "SSH key name"
  type        = string
}
