config = {}

config.clientSpawn = false
config.clientSpawnForced = {
    ['paredao'] = true
}

config.taxSafe = 0.02
config.taxDetained = 0.03
config.taxIPVA = 0.05
config.ipvaDays = 7

config.vehicles = {
    ['amarok'] = { name = 'Amarok', maker = 'Volkswagen', price = 1000000, trunk = 50, glove = 15, type = 'car', class = 'boats', banned = false },
    ['kuruma'] = { name = 'Kuruma', maker = 'GTA', price = 1000000, trunk = 50, glove = 15, type = 'car', class = 'boats', banned = false },
    ['bison3'] = { name = 'Bison 3', maker = 'GTA', price = 1000000, trunk = 50, glove = 15, type = 'car', class = 'boats', banned = false }
}

config.garages = {
    {
        coords = vector3(-809.3035, -2695.567, 13.80471), 
        rule = 'carOnly', marker = 'boat',
        points = {
            vector4(-806.4927, -2691.155, 13.81205,10.631196975708)	
        },
        vehicles = {
            'bison3',
            'kuruma',
            'amarok'
        }
    }
}

config.rules = {
    ['carOnly'] = {
        ['show_classes'] = nil,
        ['hide_classes'] = { ['planes'] = true, ['helicopters'] = true, ['boats'] = true }
    },
    ['heliOnly'] = {
        ['show_classes'] = { ['helicopters'] = true },
        ['hide_classes'] = nil
    },
    ['planeOnly'] = {
        ['show_classes'] = { ['planes'] = true },
        ['hide_classes'] = nil
    },
    ['boatsOnly'] = {
        ['show_classes'] = { ['boats'] = true },
        ['hide_classes'] = nil
    },
}

config.hashes = {}

for vname, data in pairs(config.vehicles) do
	if (data.hash) then
		config.hashes[data.hash] = vname
	else		
		local model = GetHashKey(vname)
		config.vehicles[vname].hash = model
		config.hashes[model] = vname
	end
end