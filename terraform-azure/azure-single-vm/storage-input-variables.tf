# Input variable definitions
variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "staticwebsite"
}
variable "storage_account_tier" {
  description = "Storage Account Tier"
  type        = string
  default     = "Standard"
}
variable "storage_account_replication_type" {
  description = "Storage Account Replication Type"
  type        = string
  default     = "LRS"
}
variable "storage_account_kind" {
  description = "Storage Account Kind"
  type        = string
  default     = "StorageV2"
}
variable "static_website_index_document" {
  description = "static website index document"
  type        = string
  default     = "index.html"
}
variable "static_website_error_404_document" {
  description = "static website error 404 document"
  type        = string
  default     = "error.html"
}