data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                        = "kv-${ lower(var.project) }"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  
  sku_name = "standard"

  # Política de acceso para el usuario/service principal actual
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = var.key_permissions
    secret_permissions = var.secret_permissions
    certificate_permissions = var.certificate_permissions

  }

  tags = var.tags
}
