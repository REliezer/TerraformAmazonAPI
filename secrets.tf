# Secrets para variables de entorno de tu proyecto
resource "azurerm_key_vault_secret" "db_password" {
  name         = "database-admin-password"
  value        = var.admin_sql_password
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "firebase_api_key" {
  name         = "firebase-api-key"
  value        = var.firebase_api_key
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "jwt_secret" {
  name         = "jwt-secret-key"
  value        = var.secret_key
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "sql_driver" {
  name         = "sql-driver"
  value        = var.sql_driver
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "acr_username" {
  name         = "acr-username"
  value        = var.acr_username
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "acr_password" {
  name         = "acr-password"
  value        = var.acr_password
  key_vault_id = azurerm_key_vault.keyvault.id
}
