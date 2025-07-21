# Amazon API - Infraestructura como Código 🏗️

Este repositorio contiene la configuración de **Terraform** para desplegar automáticamente toda la infraestructura de Azure necesaria para el proyecto [Amazon API](https://github.com/REliezer/amazonAPI).

## 🎯 Descripción

Con este código de Terraform puedes crear automáticamente un entorno completo en Azure que incluye todos los servicios necesarios para ejecutar la Amazon API en la nube, desde bases de datos hasta contenedores y monitoreo.

## 🏗️ Arquitectura

La infraestructura desplegada incluye los siguientes componentes de Azure:

```
Azure Resource Group
├── 🗄️  SQL Server + Database (dbserver-amazonproducts-dev)
├── 🔐 Key Vault (kv-amazonproducts) 
├── 📦 Container Registry (acramazonproductsdev)
├── ⚡ Redis Cache (amazondbcache)
├── 🌐 App Service Plan + Web App (api-amazonproducts-dev)
├── 📊 Application Insights (appinsights-amazonproducts-dev)
├── 🗃️  Storage Account (saamazonproducts)
└── 🔄 Data Factory (df-amazonproducts-dev)
```

## 📋 Recursos Creados

| Recurso | Nombre | SKU/Tier | Propósito |
|---------|--------|----------|-----------|
| **SQL Server** | `dbserver-amazonproducts-dev` | Basic | Base de datos principal para productos y usuarios |
| **SQL Database** | `dbamazonproducts` | Basic | Almacén de datos de la aplicación |
| **Key Vault** | `kv-amazonproducts` | Standard | Gestión segura de secretos y claves |
| **Container Registry** | `acramazonproductsdev` | Basic | Registro de imágenes Docker |
| **Redis Cache** | `amazondbcache` | Basic C0 | Cache de aplicación para mejorar rendimiento |
| **App Service** | `api-amazonproducts-dev` | F1 (Free) | Hosting de la API FastAPI |
| **Application Insights** | `appinsights-amazonproducts-dev` | Web | Monitoreo y telemetría |
| **Storage Account** | `saamazonproducts` | Standard LRS | Almacenamiento para Data Factory |
| **Data Factory** | `df-amazonproducts-dev` | - | Procesos ETL y pipelines de datos |

## 🚀 Inicio Rápido

### Prerrequisitos

- **Azure CLI** instalado y configurado
- **Terraform** v1.0+ instalado
- Suscripción activa de Azure
- Permisos de **Contributor** en la suscripción

### 1. Clonar el repositorio

```bash
git clone https://github.com/REliezer/TerraformAmazonAPI
cd TerraformAmazonAPI
```

### 2. Configurar variables

Crea un archivo `local.tfvars` con tus valores:

```hcl
# Azure Configuration
subscription_id = "your-azure-subscription-id"

# Database Configuration
admin_sql_password = "YourSecurePassword123!"
sql_driver        = "ODBC Driver 17 for SQL Server"

# Firebase Configuration
firebase_api_key = "your-firebase-api-key"

# Secret Key for Token
secret_key = "your-jwt-secret-key-for-app"
```
### 3. Desplegar la infraestructura

```bash
# Inicializar Terraform
terraform init

# Revisar el plan de despliegue
terraform plan -var-file="local.tfvars"

# Aplicar la configuración
terraform apply -var-file="local.tfvars"
```

### 4. Confirmar despliegue

Cuando Terraform termine, verás las salidas importantes. Guarda estos valores para configurar tu aplicación.

## 🔧 Configuración Post-Despliegue

### Configurar Base de Datos

1. **Conectar a SQL Server** usando Azure Portal o SQL Server Management Studio
2. **Crear el esquema**:
   ```sql
   CREATE SCHEMA amazon;
   ```
3. **Importar las tablas y datos** desde el repositorio de la API

### Configurar Application Insights

1. Copia la **Connection String** desde Azure Portal
2. Agrégala como secret `applicationinsights-connection-string` en Key Vault

### Configurar Redis

1. La cadena de conexión se genera automáticamente
2. Agrégala como secret `redis-connection-string` en Key Vault

## 📂 Estructura del Proyecto

```
terraform/
├── main.tf              # Proveedor de Azure y Resource Group
├── variables.tf         # Definición de variables
├── acr.tf              # Azure Container Registry
├── db.tf               # SQL Server y Database  
├── keyvault.tf         # Key Vault y políticas de acceso
├── secrets.tf          # Secrets almacenados en Key Vault
├── redis.tf            # Azure Cache for Redis
├── webapps.tf          # App Service Plan y Web App
├── insights.tf         # Application Insights
├── storage.tf          # Storage Account para Data Factory
├── df.tf               # Azure Data Factory
└── README.md           # Este archivo
```

## 🔐 Gestión de Secretos

Todos los secretos sensibles se almacenan automáticamente en **Azure Key Vault**:

| Secret Name | Descripción |
|-------------|-------------|
| `sql-server` | Nombre del servidor SQL Server |
| `sql-database` | Nombre de la base de datos |
| `sql-username` | Usuario administrador de SQL Server |
| `sql-password` | Contraseña del administrador de SQL Server |
| `firebase-api-key` | API Key de Firebase para autenticación |
| `jwt-secret-key` | Clave secreta para tokens JWT |
| `sql-driver` | Driver ODBC para SQL Server |
| `acr-username` | Usuario del Container Registry |
| `acr-password` | Contraseña del Container Registry |
| `applicationinsights-connection-string` | Cadena de conexión para Application Insights |
| `redis-connection-string` | Cadena de conexión para Redis Cache |

## ⚙️ Variables de Configuración

### Variables Requeridas

| Variable | Tipo | Descripción |
|----------|------|-------------|
| `subscription_id` | string | ID de suscripción de Azure |
| `admin_sql_password` | string | Contraseña para SQL Server |
| `firebase_api_key` | string | API Key de Firebase |
| `secret_key` | string | Clave secreta para JWT |
| `sql_driver` | string | Driver ODBC |

## 🚀 Despliegue de la Aplicación

Una vez que la infraestructura esté lista:

1. **Construir y subir la imagen Docker**:
   ```bash
   # Login al registry
   az acr login --name acramazonproductsdev
   
   # Build y push
   docker build -t amazonapi:latest .
   docker tag amazonapi:latest acramazonproductsdev.azurecr.io/amazonapi:latest
   docker push acramazonproductsdev.azurecr.io/amazonapi:latest
   ```

2. **La Web App se actualizará automáticamente** con la nueva imagen

## 📊 Monitoreo

### Application Insights
- **Métricas de rendimiento** automáticas
- **Logs de aplicación** centralizados  
- **Alertas** configurables

### Acceso a métricas:
```bash
# Ver logs en tiempo real
az webapp log tail --name api-amazonproducts-dev --resource-group rg-amazonproducts-dev
```

## 🧹 Limpieza de Recursos

Para eliminar toda la infraestructura:

```bash
terraform destroy -var-file="local.tfvars"
```

⚠️ **Advertencia**: Esto eliminará **todos** los recursos y datos. Asegúrate de hacer backup de la base de datos si es necesario.

## 💰 Estimación de Costos

Con la configuración por defecto (tiers básicos/gratuitos):

| Servicio | Tier | Costo Estimado/Mes |
|----------|------|-------------------|
| SQL Database | Basic | ~$5 USD |
| App Service | F1 (Free) | $0 USD |
| Redis Cache | Basic C0 | ~$17 USD |
| Storage Account | Standard LRS | ~$1-2 USD |
| Application Insights | Básico | ~$2-5 USD |
| Key Vault | Standard | ~$1 USD |
| Container Registry | Basic | ~$5 USD |
| Data Factory | Pay-per-use | Variable |

**Total estimado: ~$30-35 USD/mes**

## 🔄 Actualizaciones

Para aplicar cambios a la infraestructura:

```bash
# Revisar cambios
terraform plan -var-file="local.tfvars"

# Aplicar cambios
terraform apply -var-file="local.tfvars"
```

## 🐛 Resolución de Problemas

### Error: Key Vault ya existe
```bash
az keyvault purge --name kv-amazonproducts --location "Central US"
```

### Error: SQL Server name not available
Cambia el valor de `project` o `environment` en `local.tfvars`

### Error: Insufficient permissions
Asegúrate de tener permisos de **Contributor** en la suscripción

## 🤝 Contribución

1. Fork el proyecto
2. Crea una feature branch (`git checkout -b feature/new-resource`)
3. Commit tus cambios (`git commit -m 'Add new Azure resource'`)
4. Push a la branch (`git push origin feature/new-resource`)
5. Abre un Pull Request

## 📚 Referencias

- [Documentación de Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Repositorio de la API](https://github.com/REliezer/amazonAPI)

## 📄 Licencia

Este proyecto está bajo la licencia MIT. Ver `LICENSE` para más detalles.

---

**Desarrollado con ❤️ para el curso de Expertos UNAH**

### 🔗 Enlaces Relacionados

- **API Repository**: [Amazon API](https://github.com/REliezer/amazonAPI)
- **Live Demo**: Disponible después del despliegue en `https://api-amazonproducts-dev.azurewebsites.net`
