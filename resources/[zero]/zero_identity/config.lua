Proxy = module("zero","lib/Proxy")
Tunnel = module("zero", "lib/Tunnel")
zero = Proxy.getInterface('zero')

config = {}

config.general = {
    _defaultPhoto = 'https://cdn.discordapp.com/attachments/922885255386517535/1130947180367192144/BACKGROUND_ZERO_1.png',
    staffPermission = 'staff.permissao',
    perms = { 'policia.permissao', 'staff.permissao' }
}