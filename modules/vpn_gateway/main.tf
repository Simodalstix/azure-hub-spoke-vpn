resource "azurerm_public_ip" "vpn_pip" {
  name                = "${var.name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn_pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }
}

module "hub_vpn_gateway" {
  source              = "../modules/vpn_gateway"
  name                = "hub-vpn-gw"
  location            = "Australia Southeast"
  resource_group_name = "rg-hub"
  subnet_id           = module.hub_vnet.subnet_ids["GatewaySubnet"]
}
