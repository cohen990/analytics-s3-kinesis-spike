variable "api_name" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "firehose_buffer_size" {
  type = number
}

variable "firehose_buffer_time" {
  type = number
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

variable "cert_arn" {
  type = string
}

variable "custom_domain" {
  type = string
}
