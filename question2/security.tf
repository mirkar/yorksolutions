resource "azurerm_network_security_group" "apache" {
  for_each            = toset(var.locations)
  name                = "${var.rg_name_prefix}-apache-${each.value}"
  location            = each.value
  resource_group_name = "${var.rg_name_prefix}-${each.value}"

  security_rule {
    name                       = "HTTP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


}

resource "azurerm_network_security_group" "tomcat" {
  for_each            = toset(var.locations)
  name                = "${var.rg_name_prefix}-tomcat-${each.value}"
  location            = each.value
  resource_group_name = "${var.rg_name_prefix}-${each.value}"

  security_rule {
    name                       = "HTTP-8080"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "10.0.10.0/24"
    destination_address_prefix = "*"
  }


}


resource "azurerm_network_security_group" "mysql" {
  for_each            = toset(var.locations)
  name                = "${var.rg_name_prefix}-mysql-${each.value}"
  location            = each.value
  resource_group_name = "${var.rg_name_prefix}-${each.value}"

  security_rule {
    name                       = "MYSQL"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "10.0.11.0/24"
    destination_address_prefix = "*"
  }


}




