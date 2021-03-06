variable "rg_name_prefix" {
  description = "Resource groups prefix"
  type        = string
  default     = "my-test-candidate"
}


variable "locations" {
  description = "Create resource groups in these locations"
  type        = list(string)
  default     = ["eastus", "westus"]
}