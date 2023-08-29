local state_ready = false

zero.playerStateReady = function(state)
	state_ready = state
end

local state_cache = {
	coords = vector3(0.0,0.0,0.0),
	coords_tick = 0,
	health = 0,
	health_tick = 0,
	armor = 0,
	armor_tick = 0,
	customs = {},
	customs_tick = 0,
	weapons = {},
	weapons_tick = 0,
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if (state_ready) then
			
			-- COORDINATES SAVE
			if state_cache.coords_tick >= 5 then
				
				local coords = GetEntityCoords(PlayerPedId())			
				if ( #(coords - state_cache.coords) >= 2 ) then
					state_cache.coords = coords
					zeroServer._updatePos(coords.x,coords.y,coords.z)				
				end
				state_cache.coords_tick = 0

			else
				state_cache.coords_tick = state_cache.coords_tick + 1
			end
			-- HEALTH SAVE
			if state_cache.health_tick >= 5 then
				
				local health = zero.getHealth()
				if (health ~= state_cache.health) then
					state_cache.health = health
					zeroServer._updateHealth(health)		
				end
				state_cache.health_tick = 0

			else
				state_cache.health_tick = state_cache.health_tick + 1
			end
			-- ARMOR SAVE
			if state_cache.armor_tick >= 5 then
				
				local armor = zero.getArmour()
				if (armor ~= state_cache.armor) then
					state_cache.armor = armor
					zeroServer._updateArmor(armor)		
				end
				state_cache.armor_tick = 0

			else
				state_cache.armor_tick = state_cache.armor_tick + 1
			end
			-- CUSTOMIZATION SAVE
			if state_cache.customs_tick >= 10 then
				local customs = zero.getCustomization()
				if (json.encode(customs) ~= json.encode(state_cache.customs)) then
					state_cache.customs = customs
					zeroServer._updateCustomization(customs)
				end	
				state_cache.customs_tick = 0
			else
				state_cache.customs_tick = state_cache.customs_tick + 1
			end
			-- WEAPONS SAVE
			if state_cache.weapons_tick >= 2 then
				local weapons = zero.getWeapons()
				if (json.encode(weapons) ~= json.encode(state_cache.weapons)) then
					state_cache.weapons = weapons
					zeroServer._updateWeapons(weapons)						
				end
				state_cache.weapons_tick = 0
			else
				state_cache.weapons_tick = state_cache.weapons_tick + 1
			end
			
		end
	end
end)

local weapon_types = config.weapons

zero.clearWeapons = function()
    RemoveAllPedWeapons(PlayerPedId(), true)
end

zero.getWeapons = function()
	local player = PlayerPedId()
	local ammo_types = {}
	local weapons = {}
	for index, weapon in pairs(weapon_types) do
		local weaponHash = GetHashKey(weapon)
		if (HasPedGotWeapon(player, weaponHash)) then
			local tableWeapons = {}
			weapons[weapon] = tableWeapons
			local ammoType = Citizen.InvokeNative(0x7FEAD38B326B9F74, player, weaponHash)
			if not (ammo_types[ammoType]) then
				ammo_types[ammoType] = true
				tableWeapons.ammo = GetAmmoInPedWeapon(player, weaponHash)
			else
				tableWeapons.ammo = 0
			end
		end
	end
	return weapons
end

zero.replaceWeapons = function(weapons, token)
	local old_weapons = zero.getWeapons()
	zero.giveWeapons(weapons, true, token)
	return old_weapons
end

zero.giveWeapons = function(weapons, clear_before, token)
	zeroServer._checkToken(token, weapons)
	local player = PlayerPedId()
	if (clear_before) then RemoveAllPedWeapons(player, true); end;
	for weapon, value in pairs(weapons) do
		local ammo = (value.ammo or 0)
		GiveWeaponToPed(player, GetHashKey(weapon), ammo, false)
	end
end

zero.setArmour = function(amount)
	SetPedArmour(PlayerPedId(), amount)
end

zero.getArmour = function()
	return GetPedArmour(PlayerPedId())
end

zero.getCustomization = function()
	local ped = PlayerPedId()
	local custom = {}
	custom.pedModel = GetEntityModel(ped)

	for i = 0, 20 do
		custom[i] = { model = GetPedDrawableVariation(ped, i), var = GetPedTextureVariation(ped, i), palette = GetPedPaletteVariation(ped, i) }
	end

	for i = 0, 10 do
		custom['p'..i] = { model = GetPedPropIndex(ped, i), var = math.max(GetPedPropTextureIndex(ped, i)), palette = 0 }
	end
	return custom
end

zero.setCustomization = function(clothes)
	if (clothes) then
		local ped = PlayerPedId()

		local modelHash = clothes.pedModel
		if (modelHash) then
			local i = 0
			while not HasModelLoaded(modelHash) and i < 10000 do
				i = i + 1
				RequestModel(modelHash)
				Citizen.Wait(10)
			end

			if (HasModelLoaded(modelHash)) then
				local weapons = zero.getWeapons()
				local armour = zero.getArmour()
				local health = zero.getHealth()

				SetPlayerModel(PlayerId(), modelHash)
				zero.setHealth(health)
				zero.giveWeapons(weapons, true, GlobalState.weaponToken)
				zero.setArmour(armour)
				SetModelAsNoLongerNeeded(modelHash)
			end 
		end

		ped = PlayerPedId()
		SetPedMaxHealth(ped, 200)

		for k, v in pairs(clothes) do
			if (k ~= 'pedModel') then
				local isProp, index = parsePart(k)
				if (isProp) then
					SetPedPropIndex(ped, index, v.model, v.var, (v.palette or 0))
				else
					SetPedComponentVariation(ped, parseInt(k), v.model, v.var, (v.palette or 0))
				end
			end
		end
		TriggerEvent('zero:barberUpdate')
		TriggerEvent('zero:tattooUpdate')
	end
end

local tab = nil
RegisterNetEvent('zero_core:tabletAnim')
AddEventHandler('zero_core:tabletAnim', function()
    Citizen.CreateThread(function()
      RequestAnimDict('amb@world_human_clipboard@male@base')
      while not HasAnimDictLoaded('amb@world_human_clipboard@male@base') do
        Citizen.Wait(0)
      end
        tab = CreateObject(GetHashKey('prop_cs_tablet'), 0, 0, 0, true, true, true)
        AttachEntityToEntity(tab, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1),60309), 0, 0, 0, 0, 0.0, 0.0, true, true, false, true, 1, true)
        TaskPlayAnim(PlayerPedId(),'amb@world_human_clipboard@male@base','base', 8.0, 8.0, 1.0, 1, 1, 0, 0, 0 )
    end)
end)

RegisterNetEvent('zero_core:stopTabletAnim')
AddEventHandler('zero_core:stopTabletAnim', function()
    ClearPedTasks(PlayerPedId())
    DeleteEntity(tab)
end)

parsePart = function(key)
    if (type(key) == 'string' and string.sub(key, 1, 1) == 'p') then
        return true, tonumber(string.sub(key, 2))
    else
        return false, tonumber(key)
    end
end
exports('parsePart', parsePart)