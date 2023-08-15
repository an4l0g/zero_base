local config = module('zero_core','cfg/cfgBlips')

Citizen.CreateThread(function()
	for _,v in pairs(config.blips) do
		local blip = AddBlipForCoord(v.coords.x,v.coords.y,v.coords.z)
		SetBlipSprite(blip,v.sprite)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v.color)
		SetBlipScale(blip,v.scale)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(v.nome)
		EndTextCommandSetBlipName(blip)
	end
end)