Proxy = module('zero', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

config = {}

config.weathers = {
    { name = 'CLEAR', active = true }, -- CEÚ LIMPO
    { name = 'CLEARING', active = true, blacklist = true }, -- CHUVA COM CEÚ LIMPO
    { name = 'CLOUDS', active = true }, -- CEÚ CHEIO DE NUVENS
    { name = 'EXTRASUNNY', active = true }, -- SOL FORTE
    { name = 'FOGGY', active = true }, -- NEBLINA
    { name = 'NEUTRAL', active = true, blacklist = true }, -- CHUVA COM NUVE + SOL
    { name = 'OVERCAST', active = true }, -- NUBLADO
    { name = 'RAIN', active = true, blacklist = true }, -- CHUVA
    { name = 'SMOG', active = true }, -- POLUIÇÃO
    { name = 'THUNDER', active = true, blacklist = true }, -- CHUVA FORTE
    { name = 'HALLOWEEN', active = false }, -- HALLOWEEN
    { name = 'SNOW', active = false }, -- NEVE
    { name = 'XMAS', active = false },-- NATAL
    { name = 'SNOWLIGHT', active = false }, -- NEVE LEVE
    { name = 'BLIZZARD', active = false }, -- NEVASCA
}