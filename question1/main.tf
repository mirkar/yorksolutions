resource "azurerm_resource_group" "rg" {
  for_each = toset(var.locations)
  name     = "${var.rg_name_prefix}-${each.value}"
  location = each.value

}  