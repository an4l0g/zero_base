Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')

config = {}

config.general = {
    ['maxHealth'] = 400,
    ['spawnCreator'] = vector4(-2043.7, -1031.62, 11.99, 70.866142272949),
    ['spawnAfterCreator'] = vector4(-1037.74, -2737.8, 20.17, 331.65353393555),
    ['spawnLocations'] = {
        ['praca'] = { 
			['coord'] = vector4(55.04,-878.8,30.37,176.39), 
			['permission'] = nil
		},
		['sandy'] = { 
			['coord'] = vector4(318.1,2623.98,44.47,268.35), 
			['permission'] = nil
		},
		['paleto'] = { 
			['coord'] = vector4(-772.95,5595.9,33.49,168.85), 
			['permission'] = nil
		},
		['aeroporto'] = { 
			['coord'] = vector4(-1037.69,-2737.71,20.17,327.48), 
			['permission'] = nil
		},
		['dp'] = { 
			['coord'] = vector4(-432.13, 1116.49, 326.77, 258.65), 
			['permission'] = 'policia.permissao'
		}
    }
}