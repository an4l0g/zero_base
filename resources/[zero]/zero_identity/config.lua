config = {}

config.webhooks = {
    updatePhoto = 'https://discord.com/api/webhooks/1130963392740458518/sA4kq5SCqYQB1gYTy_fkyFFNqJjY7Sao4cFIwdFwVy8dmiteRPvzFv_YzM23o1kNuXX1',
    verifyRG = 'https://discord.com/api/webhooks/1130964724192923658/tCQkCHcv0FSTM_EYgr-swlia8ynMMaJhhuXe5-uhuOZ_4QjKzla5vOzg8VZlDicccQNW'
}

config.general = {
    _defaultPhoto = 'https://cdn.discordapp.com/attachments/922885255386517535/1130947180367192144/BACKGROUND_ZERO_1.png',
    staffPermission = 'staff.permissao',
    perms = { 'policia.permissao', 'staff.permissao' }
}

Proxy = module('zero','lib/Proxy')
Tunnel = module('zero', 'lib/Tunnel')
zero = Proxy.getInterface('zero')

if IsDuplicityVersion() then
    zeroClient = Tunnel.getInterface('zero')
end