local vSERVER = Tunnel.getInterface('Business')
local config = module('zero_core', 'cfg/cfgBusiness')

local inBusiness = false
local nearestBlips = {}

local _markerThread = false
local markerThread = function()
    if (_markerThread) then return; end;
    _markerThread = true
    Citizen.CreateThread(function()
        while (countTable(nearestBlips) > 0) do
            local ped = PlayerPedId()
            local _cache = nearestBlips
            for index, dist in pairs(_cache) do
                local _config = config.empresa[index]
                TextFloating('~b~E~w~ - Entrar na empresa', _config.coords.enter.xyz)
                if (dist <= 1.2 and IsControlJustReleased(0, 38)) then
                    if (vSERVER.checkBusiness(index)) then
						vSERVER.saveTemp()
                        DoScreenFadeOut(500)
						Citizen.Wait(500)

                        vSERVER.setBucket(ped)
                        zero.teleport(_config.coords.exit.x, _config.coords.exit.y, _config.coords.exit.z)			
                        SetEntityHeading(ped, _config.coords.exit.w)

                        Citizen.Wait(500)
                        DoScreenFadeIn(500)

                        inBusiness = true
						enterBusiness(index)
                    end
                end
            end
            Citizen.Wait(1)
        end
        _markerThread = false
    end)
end

local BlipBusiness = function()
	local BuyedBusiness = vSERVER.getBuyedBusiness()
	for k, v in pairs(BuyedBusiness) do
		local BusinessBlip = config.empresa[k]
		if (BusinessBlip) then
			local blip = AddBlipForCoord(BusinessBlip.coords.enter.x, BusinessBlip.coords.enter.y, BusinessBlip.coords.enter.z)
			SetBlipSprite(blip, 351)
			SetBlipAsShortRange(blip, true)
			SetBlipColour(blip, 36)
			SetBlipScale(blip, 0.5)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString('Empresa de '..v.owner)
			EndTextCommandSetBlipName(blip)
		end
	end
end

Citizen.CreateThread(function()
	BlipBusiness()
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        nearestBlips = {}
        for k, v in pairs(config.empresa) do
            local distance = #(pCoord - v.coords.enter.xyz)
            if (distance <= 2) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(1000)
    end
end)

enterBusiness = function(business)
	Citizen.CreateThread(function()
		while (inBusiness) do
			local idle = 1000
			local ped = PlayerPedId()
			local exit = config.empresa[business]['coords']['exit']
			local distance = #(GetEntityCoords(ped) - exit.xyz)
			if distance <= 2.5 then
				idle = 5
				TextFloating('~b~E~w~ - Sair da empresa', exit.xyz)
				if distance <= 1.2 and IsControlJustPressed(0, 38) then
					DoScreenFadeOut(1000)
					Citizen.Wait(1000)
					vSERVER.setBucket(0)
					SetEntityCoords(ped, config.empresa[business]['coords']['enter'].xyz)
					SetEntityHeading(ped, config.empresa[business]['coords']['enter'].w)
					Citizen.Wait(1000)
					DoScreenFadeIn(1000)
					vSERVER.deleteTemp()
					inBusiness = false
				end 
			end
			Citizen.Wait(idle)
		end
	end)

	Citizen.CreateThread(function()
		while (inBusiness) do
			local idle = 1000
			local ped = PlayerPedId()
			local safe = config.empresa[business]['coords']['safe']
			local distance = #(GetEntityCoords(ped) - safe.xyz)
			if distance <= 2.5 then
				idle = 5
				TextFloating('~b~E~w~ - Cofre', safe.xyz)
				if distance <= 1.2 and IsControlJustPressed(0, 38) then
					vSERVER.getMoney(business)
				end 
			end
			Citizen.Wait(idle)
		end
	end)
end