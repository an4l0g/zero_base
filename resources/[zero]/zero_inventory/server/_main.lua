vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

cInventory = Tunnel.getInterface('zero_inventory')

sInventory = {}
Tunnel.bindInterface('zero_inventory', sInventory)