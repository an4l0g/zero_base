local trackerEnabled = false
local userGroup = ''
local userBlipType = 'foot'
local players = {}
local lastUpdate = 0
local elapsedTime = 0

RegisterNetEvent('zero_blips:setEnabled', function(group)
	trackerEnabled = (type(group) == 'string')
	userGroup = (group or '')
	userBlipType = 'foot'
	if (not trackerEnabled) then
		CleanupBlips()
	end
end)

RegisterNetEvent('zero_blips:playerRemoved',function(source)
	if players[source] and DoesBlipExist(players[source].blip) then
		RemoveBlip(players[source].blip)
		players[source] = nil
	end
end)

RegisterNetEvent('zero_blips:update',function(data)
	local gameTimer = GetGameTimer()
    elapsedTime = gameTimer - lastUpdate
    lastUpdate = gameTimer
	for group, users in pairs(data) do
		for src, mode in pairs(users) do
			local player = players[src]
			local coords = mode.coords.xyz
			if (not player) or (not DoesBlipExist(player.blip)) then
				players[src] = { blip = AddBlipForCoord(coords), start = coords, current = coords, destination = coords }
				player = players[src]
			else
				player.destination = coords
    			player.start = player.current				
			end
			SetBlipSquaredRotation(player.blip, mode.coords.w)
			SettingBlip(player.blip,group,mode.btype)
		end
	end
	SyncUserBlipType()
end)

Clamp = function(x, min, max)
    return math.max(math.min(x, max), min)
end

Lerp = function(a, b, t)
    return a + (b - a) * t
end

SettingBlip = function(blip, group, btype)
	local styles = (config.groupsFormats[group] or config.groupsFormats['default'])
	if (DoesBlipExist(blip)) then
		local styled = styles[btype] or styles['foot']
		if (type(styled) == 'string') then styled = styles[styled]; end;

		SetBlipSprite(blip, styled.sprite)
		SetBlipColour(blip, styled.colour)
		SetBlipScale(blip, styled.scale)
		SetBlipAsShortRange(blip, styled.short)
		SetBlipShowCone(blip, styled.cone)
		ShowHeadingIndicatorOnBlip(blip, styled.pointer)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(group)
		EndTextCommandSetBlipName(blip)
	end
end

SyncUserBlipType = function()
	local newType = userBlipType
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	if (vehicle > 0) then
		newType = 'car'
		local class = GetVehicleClass(vehicle)
		if ((class == 8) or (class == 13)) then newType = 'bike';
		elseif (class == 15) then newType = 'heli';
		elseif (class == 16) then newType = 'plane'; end
	else
		newType = 'foot'
	end
	if (newType ~= userBlipType) then
		TriggerServerEvent('zero_blips:updateType', userGroup, newType)
		userBlipType = newType
	end
end

CleanupBlips = function()
	for k, v in pairs(players) do
		RemoveBlip(v.blip)
		players[k] = nil
	end
end