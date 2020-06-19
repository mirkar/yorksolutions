resource "azurerm_virtual_network" "vnet" {
  for_each            = toset(var.locations)
  name                = "${var.rg_name_prefix}-vnet-${each.value}"
  location            = each.value
  address_space       = ["10.0.0.0/16"]
  resource_group_name = "${var.rg_name_prefix}-${each.value}"
}

resource "azurerm_subnet" "apache" {
  for_each             = toset(var.locations)
  name                 = "${var.rg_name_prefix}-t1subnet-${each.value}"
  virtual_network_name = "${var.rg_name_prefix}-vnet-${each.value}"
  resource_group_name  = "${var.rg_name_prefix}-${each.value}"
  address_prefix       = "10.0.10.0/24"
}

resource "azurerm_subnet_network_security_group_association" "apache" {
  for_each                  = toset(var.locations)
  subnet_id                 = azurerm_subnet.apache[each.value].id
  network_security_group_id = azurerm_network_security_group.apache[each.value].id
}


resource "azurerm_subnet" "tomcat" {
  for_each             = toset(var.locations)
  name                 = "${var.rg_name_prefix}-t2subnet-${each.value}"
  virtual_network_name = "${var.rg_name_prefix}-vnet-${each.value}"
  resource_group_name  = "${var.rg_name_prefix}-${each.value}"
  address_prefix       = "10.0.11.0/24"
}

resource "azurerm_subnet_network_security_group_association" "tomcat" {
  for_each                  = toset(var.locations)
  subnet_id                 = azurerm_subnet.tomcat[each.value].id
  network_security_group_id = azurerm_network_security_group.tomcat[each.value].id
}


resource "azurerm_subnet" "db" {
  for_each             = toset(var.locations)
  name                 = "${var.rg_name_prefix}-t3subnet-${each.value}"
  virtual_network_name = "${var.rg_name_prefix}-vnet-${each.value}"
  resource_group_name  = "${var.rg_name_prefix}-${each.value}"
  address_prefix       = "10.0.0.32/28"
}

resource "azurerm_subnet_network_security_group_association" "db" {
  for_each                  = toset(var.locations)
  subnet_id                 = azurerm_subnet.db[each.value].id
  network_security_group_id = azurerm_network_security_group.mysql[each.value].id
}

