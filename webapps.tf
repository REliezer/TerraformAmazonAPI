//Definicion del servidor web
resource "azurerm_service_plan" "sp" {
    name = "sp-${ var.project }-${ var.environment}"
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
    sku_name = "F1"  //Probar F1 que es free o B1
    os_type = "Linux"
    tags = var.tags
}

//Crear de la web apps: API
resource "azurerm_linux_web_app" "webappapi" {
    name = "api-${ var.project }-${ var.environment}"
    location = var.location
    resource_group_name = azurerm_resource_group.rg.name
    service_plan_id = azurerm_service_plan.sp.id

    site_config {
        always_on = false
        application_stack {
            docker_registry_url = "https://acramazonproductsdev.azurecr.io"
            docker_image_name = "amazonapi:latest"
            docker_registry_username = azurerm_container_registry.acr.name
            docker_registry_password = azurerm_container_registry.acr.admin_password
        }
    }

    app_settings = {
        DOCKER_ENABLE_CI = "true"
        FIREBASE_API_KEY = var.firebase_api_key
        SECRET_KEY       = var.secret_key
        SQL_DATABASE     = "db${ var.project }"
        SQL_DRIVER       = var.sql_driver
        SQL_PASSWORD     = var.admin_sql_password
        SQL_SERVER       = "${azurerm_mssql_server.sqlserver.name}.database.windows.net"
        SQL_USERNAME     = azurerm_mssql_server.sqlserver.administrator_login
        KEY_VAULT_URL    = azurerm_key_vault.keyvault.vault_uri
        WEBSITES_PORT = "80"
    }

    tags = var.tags
}