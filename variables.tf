variable "name" {
  description = "Name of the custom Event bus."
  type = string
}

variable "partner_source" {
  description = "Name of partner event source."
  type = string
  default = ""
}

# Archive variables
variable "create_archive" {
  description = "Do you need archive for custom event bus?"
  type = bool
  default = false
}

variable "description" {
  description = "Archive description."
  type = string
  default = null
}

variable "retention_days" {
  description = "Number of retention days for archive, defaults to indefinite."
  type = number
  default = null
}

variable "event_pattern" {
  description = "Event pattern for archive, if not specified all events are archived."
  type = any
  default = {}
}