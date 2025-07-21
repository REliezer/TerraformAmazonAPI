# Secrets para variables de entorno de tu proyecto
resource "azurerm_key_vault_secret" "sql_server" {
  name         = "sql-server"
  value        = azurerm_mssql_server.sqlserver.name
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "sql_database" {
  name         = "sql-database"
  value        = azurerm_mssql_database.db.name
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "sql_username" {
  name         = "sql-username"
  value        = azurerm_mssql_server.sqlserver.administrator_login
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "sql_password" {
  name         = "sql-password"
  value        = azurerm_mssql_server.sqlserver.administrator_login_password
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
  value        = azurerm_container_registry.acr.name
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "acr_password" {
  name         = "acr-password"
  value        = azurerm_container_registry.acr.admin_password
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "insights_connection_string" {
  name         = "applicationinsights-connection-string"
  value        = azurerm_application_insights.insights.connection_string
  key_vault_id = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "redis_connection_string" {
  name         = "redis-connection-string"
  value        = azurerm_redis_cache.redis.primary_connection_string
  key_vault_id = azurerm_key_vault.keyvault.id
}

