resource "azurerm_resource_group" "hub" {
  name     = "rg-hub"
  location = "Australia Southeast"
}

module "hub_vnet" {
  source              = "../modules/vnet"
  name                = "vnet-hub"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name

  subnets = {
    "AzureFirewallSubnet" = "10.0.1.0/24"
    "GatewaySubnet"       = "10.0.2.0/24"
    "AzureBastionSubnet"  = "10.0.3.0/24"
  }
}

module "hub_vpn_gateway" {
  source              = "../modules/vpn_gateway"
  name                = "hub-vpn-gw"
  location            = module.hub_vnet.location
  resource_group_name = module.hub_vnet.resource_group_name
  subnet_id           = module.hub_vnet.subnet_ids["GatewaySubnet"]
}

module "peer_hub_to_dev" {
  source = "../modules/peering"
  name   = "peer-hub-to-dev"

  resource_group_name   = "rg-hub"
  vnet_name             = module.hub_vnet.name
  remote_vnet_id        = "<spoke-dev-vnet-id>"
  allow_gateway_transit = true
  use_remote_gateways   = false
}
