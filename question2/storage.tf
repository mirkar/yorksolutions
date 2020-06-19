resource "azurerm_storage_account" "storage" {
  for_each                 = toset(var.locations)
  name                     = "ehstorage${each.value}"
  location                 = each.value
  resource_group_name      = "${var.rg_name_prefix}-${each.value}"
  account_tier             = "Standard"
  account_replication_type = "LRS"





}

