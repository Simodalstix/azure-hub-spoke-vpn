resource "azurerm_resource_group" "dev" {
  name     = "rg-dev"
  location = "Australia Southeast"
}

module "spoke_dev_vnet" {
  source              = "../../modules/vnet"
  name                = "vnet-spoke-dev"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name

  subnets = {
    "web" = "10.10.1.0/24"
    "app" = "10.10.2.0/24"
    "db"  = "10.10.3.0/24"
  }
}


# module "peer_dev_to_hub" {
#   source = "../../modules/peering"
#   name   = "peer-dev-to-hub"

#   resource_group_name   = "rg-dev"
#   vnet_name             = module.spoke_dev_vnet.name
#   remote_vnet_id        = "<hub-vnet-id>"
#   use_remote_gateways   = true
#   allow_gateway_transit = false
# }
