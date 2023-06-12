zero = Proxy.getInterface('zero')
zeroClient = Tunnel.getInterface('zero')

cInventory = Tunnel.getInterface('zero_inventory')

sInventory = {}
Tunnel.bindInterface('zero_inventory', sInventory)