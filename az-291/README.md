# Azure 291

Issues checking multiple resources with different settings.

Expected: If a setting is missing, the scenario should fail; If all settings exist, the scenario should pass

Result: NOW FIXED! :)

## Running the test:

1. Authenticate to Azure `az login`
2. cd to the solution directory `cd solution`
3. `terraform init`
4. `terraform plan -out plan.out`
5. `terraform-compliance -f ../tests -p plan.out`

## Versions

| Product | Version | 
| --- | --- |
| Terraform | v0.12.20 |
| Terraform Compliance | 1.2.9 | 

####From the plan
windowsservers-pass
```
  # azurerm_postgresql_configuration.connection_throttling will be created
  + resource "azurerm_postgresql_configuration" "connection_throttling" {
      + id                  = (known after apply)
      + name                = "connection_throttling"
      + resource_group_name = "testingtfc-rg"
      + server_name         = "tfcpostgresql1111"
      + value               = "on"
    }

  # azurerm_postgresql_configuration.log_checkpoints will be created
  + resource "azurerm_postgresql_configuration" "log_checkpoints" {
      + id                  = (known after apply)
      + name                = "log_checkpoints"
      + resource_group_name = "testingtfc-rg"
      + server_name         = "tfcpostgresql1111"
      + value               = "on"
    }

  # azurerm_postgresql_configuration.log_connections will be created
  + resource "azurerm_postgresql_configuration" "log_connections" {
      + id                  = (known after apply)
      + name                = "log_connections"
      + resource_group_name = "testingtfc-rg"
      + server_name         = "tfcpostgresql1111"
      + value               = "on"
    }

  # azurerm_postgresql_configuration.log_disconnections will be created
  + resource "azurerm_postgresql_configuration" "log_disconnections" {
      + id                  = (known after apply)
      + name                = "log_disconnections"
      + resource_group_name = "testingtfc-rg"
      + server_name         = "tfcpostgresql1111"
      + value               = "on"
    }

  # azurerm_postgresql_configuration.log_retention_days will be created
  + resource "azurerm_postgresql_configuration" "log_retention_days" {
      + id                  = (known after apply)
      + name                = "log_retention_days"
      + resource_group_name = "testingtfc-rg"
      + server_name         = "tfcpostgresql1111"
      + value               = "4"
    }
```

