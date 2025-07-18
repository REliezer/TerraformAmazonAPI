# Azure Data Factory para procesos ETL
resource "azurerm_data_factory" "df" {
  name                = "df-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags
}