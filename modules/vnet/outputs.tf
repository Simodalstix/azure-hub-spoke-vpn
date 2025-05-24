output "subnet_ids" {
  value = {
    for s in azurerm_subnet.subnets :
    s.name => s.id
  }
}
output "name" {
  value = azurerm_virtual_network.this.name
}

output "id" {
  value = azurerm_virtual_network.this.id
}
