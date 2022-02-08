variable "api_name" {
  type = string
}

variable "daily_limit" {
  type    = number
  default = 10000
}

variable "burst_limit" {
  type    = number
  default = 5000
}

variable "rate_limit" {
  type    = number
  default = 1
}

variable "log_level" {
  type    = string
  default = "OFF"
}

variable "enable_trace" {
  type    = bool
  default = false
}

variable "stage_name" {
  type    = string
  default = "v0"
}

variable "allow_origin" {
  type = string
}

variable "firehose_arn" {
  type = string
}

variable "firehose_name" {
  type = string
}

variable "cert_arn" {
  type = string
}

variable "custom_domain" {
  type = string
}
