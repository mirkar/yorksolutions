resource "azurerm_public_ip" "esodahealth" {

  for_each            = toset(var.locations)
  name                = "esodahealth-pubip-${each.value}"
  location            = "${each.value}"
  resource_group_name = "${var.rg_name_prefix}-${each.value}"
  allocation_method   = "Static"
  domain_name_label   = azurerm_resource_group.rg[each.value].name


}


resource "azurerm_lb" "esodahealth-apache" {
  for_each            = toset(var.locations)
  name                = "lb-public-${each.value}"
  location            = "${each.value}"
  resource_group_name = "${var.rg_name_prefix}-${each.value}"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.esodahealth[each.value].id
  }
}

resource "azurerm_lb" "esodahealth-tomcat" {
  for_each            = toset(var.locations)
  name                = "lb-app-${each.value}"
  location            = "${each.value}"
  resource_group_name = "${var.rg_name_prefix}-${each.value}"

}
