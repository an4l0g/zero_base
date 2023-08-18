local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')

vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local elevatorsConfiguration = cfg.elevatorsConfiguration
local elevatorsLocation = cfg.elevatorsLocation

Citizen.CreateThread(function()
	SetNuiFocus(false, false)
	while true do
		local idle = 1000
        local ped = PlayerPedId()
		local pCoord = GetEntityCoords(ped)
		for k, v in pairs(elevatorsLocation) do
			local distance = #(pCoord - elevatorsLocation[k].coord)
			if distance <= 5 then 
				idle = 5
				DrawMarker(27,elevatorsLocation[k].coord.x,elevatorsLocation[k].coord.y,elevatorsLocation[k].coord.z-0.97, 0, 0, 0, 0, 180.0, 130.0, 1.0, 1.0, 1.0, 0, 255, 0, 75, 0, 0, 0, 1)
				if distance <= 1.2 and IsControlJustPressed(0, 38) then
					local elevatorConfig = elevatorsConfiguration[elevatorsLocation[k].config]
					if vSERVER.checkPermission(elevatorConfig.permission) then
						openElevator(elevatorConfig.locations, elevatorConfig.elevatorName)
					end
				end
			end
		end
		Wait(idle)
	end
end)

local elevatorsLocationCache = {}
openElevator = function(locs, name)
	elevatorsLocationCache = locs
	SetNuiFocus(true, true)
	SendNUIMessage({ action = 'OPEN_NUI', elevatorLocs = locs, elevatorName = name })
end

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false, false)
end)

RegisterNUICallback('elevatorFloor', function(data, cb)
	local ped = PlayerPedId()
	DoScreenFadeOut(1000)
	Wait(1000)
	SetEntityCoords(ped, elevatorsLocationCache[data].coord, false, false, false, true)
	SetEntityHeading(ped, elevatorsLocationCache[data].heading)
	Wait(1000)
	SetNuiFocus(false, false)
	DoScreenFadeIn(1000)
	elevatorsLocationCache = {}
end)