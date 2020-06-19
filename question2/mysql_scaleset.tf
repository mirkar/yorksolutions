resource "azurerm_virtual_machine_scale_set" "mysql" {

  for_each = toset(var.locations)

  name                = "eh-mysql-${each.value}"
  location            = "${each.value}"
  resource_group_name = "${var.rg_name_prefix}-${each.value}"

  upgrade_policy_mode = "Manual"

  sku {
    name     = "Standard_B1s"
    tier     = "Standard"
    capacity = 1
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }

  os_profile {
    computer_name_prefix = "apachevm"
    admin_username       = "ehealth"
    admin_password       = "never%do%it#123456"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  network_profile {
    name                      = "t1networkprofile"
    primary                   = true
    network_security_group_id = azurerm_network_security_group.mysql[each.value].id

    ip_configuration {
      name      = "T1IPConfiguration${each.value}"
      primary   = true
      subnet_id = azurerm_subnet.db[each.value].id
    }
  }

}
