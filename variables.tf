variable "subscription_id" {
    type        = string
    description = "The Azure subscription ID"  
}

variable "location" {
    type        = string
    description = "The Azure region where resources will be deployed"
    default     = "Central US"
}

variable "project" {
    type        = string
    description = "The name of the project"
    default     = "amazonproducts"
}

variable "environment" {
    type        = string
    description = "The environment for the deployment (e.g., dev, test, prod)"
    default     = "dev"  
}

variable "tags" {
    type        = map(string)
    description = "A map of tags to assign to resources"
    default     = {
        environment = "development"
        date        = "jul-2025"
        createdBy   = "Terraform"
    }
}

variable "admin_sql_password" {
    type = string
    description = "The password for the SQL account"
}

variable "firebase_api_key" {
    type = string
    description = "Firebase API key for the application"
}

variable "secret_key" {
    type = string
    description = "value of the secret key for the application"
}

variable "sql_driver" {
    type = string
    description = "ODBC driver for SQL Server"
}

variable "acr_username" {
    type = string
    description = "Username for Azure Container Registry (ACR)"
}

variable "acr_password" {
    type = string
    description = "value of the secret key for the application"
}

variable "key_permissions" {
    type        = list(string)
    description = "List of key permissions."
    default     = ["List", "Create", "Delete", "Get", "Purge", "Recover", "Update"]
}

variable "secret_permissions" {
    type        = list(string)
    description = "List of secret permissions."
    default     = ["List", "Delete", "Get", "Purge", "Recover", "Set"]
}

variable "certificate_permissions" {
    type        = list(string)
    description = "List of certificate permissions."
    default     = ["Get", "List", "Create", "Delete", "Update", "Purge", "Recover"]
}