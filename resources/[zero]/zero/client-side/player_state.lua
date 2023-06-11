local state_ready = false
local weapon_list = {}	

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
		if IsPlayerPlaying(PlayerId()) and state_ready and (not LocalPlayer.state['inArena']) then
			
			-- COORDINATES SAVE
			if state_cache.coords_tick >= 5 then
				
				local coords = GetEntityCoords(PlayerPedId(),true)			
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


RegisterNetEvent('save:database',function()
	if IsPlayerPlaying(PlayerId()) and state_ready and (not LocalPlayer.state['inArena']) then
		local coords = GetEntityCoords(PlayerPedId(),true)
		local health = zero.getHealth()
		local armor = zero.getArmour()
		local customs = zero.getCustomization()
		
		if ( #(coords - state_cache.coords) >= 2 ) then
			state_cache.coords = coords
			zeroServer._updatePos(coords.x,coords.y,coords.z)				
		end

		if (health ~= state_cache.health) then
			state_cache.health = health
			zeroServer._updateHealth(health)		
		end

		if (armor ~= state_cache.armor) then
			state_cache.armor = armor
			zeroServer._updateArmor(armor)		
		end

		if (json.encode(customs) ~= json.encode(state_cache.customs)) then
			state_cache.customs = customs
			zeroServer._updateCustomization(customs)
		end	
		
	end
end)

RegisterNetEvent('save:weapons',function()
	if state_ready and (not LocalPlayer.state['inArena']) then
		zeroServer._updateWeapons(zero.getWeapons())
	end
end)

local weapon_types = {
	"WEAPON_DAGGER",
	"WEAPON_RAYPISTOL",
	"WEAPON_BAT",
	"WEAPON_BOTTLE",
	"WEAPON_CROWBAR",
	"WEAPON_FLASHLIGHT",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_HATCHET",
	"WEAPON_KNUCKLE",
	"WEAPON_KNIFE",
	"WEAPON_MACHETE",
	"WEAPON_SWITCHBLADE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_WRENCH",
	"WEAPON_BATTLEAXE",
	"WEAPON_POOLCUE",
	"WEAPON_STONE_HATCHET",
	"WEAPON_PISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_STUNGUN",
	"WEAPON_SNSPISTOL",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_REVOLVER",
	"WEAPON_MUSKET",
	"WEAPON_FLARE",
	"GADGET_PARACHUTE",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_MICROSMG",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_COMBATPDW",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_CARBINERIFLE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_PETROLCAN",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_FLAREGUN",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_FLARE",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_BALL"
}

zero.clearWeapons = function()
    RemoveAllPedWeapons(PlayerPedId(), true)
	weapon_list = {}
end

zero.getWeapons = function()
	local player = PlayerPedId()
	local ammo_types = {}
	local weapons = {}
	for k,v in pairs(weapon_types) do
		local hash = GetHashKey(v)
		if HasPedGotWeapon(player,hash) then
			local weapon = {}
			weapons[v] = weapon
			local atype = Citizen.InvokeNative(0x7FEAD38B326B9F74,player,hash) -- GET_PED_AMMO_TYPE_FROM_WEAPON
			if ammo_types[atype] == nil then
				ammo_types[atype] = true
				weapon.ammo = GetAmmoInPedWeapon(player,hash)
			else
				weapon.ammo = 0
			end
		end
	end
	return zero.legalWeaponsChecker(weapons)
end

zero.replaceWeapons = function(weapons, token)
	local old_weapons = zero.getWeapons()
	zero.giveWeapons(weapons,true,token)
	return old_weapons
end

zero.giveWeapons = function(weapons, clear_before, token)
	zeroServer._checkToken(token, weapons)
	local player = PlayerPedId()
	print(json.encode(weapons))
	if (clear_before) then RemoveAllPedWeapons(player, true); weapon_list = {}; end;
	for weapon, value in pairs(weapons) do
		local ammo = (value.ammo or 0)
		GiveWeaponToPed(player, GetHashKey(weapon), ammo, false)
		weapon_list[string.upper(k)] = value
	end
end

zero.getWeaponsLegal = function()								
	return weapon_list
end

zero.legalWeaponsChecker = function(weapon)
	local weapon = weapon
	local weapons_legal = zero.getWeaponsLegal()
	local ilegal = false
	local ilegal_log = {}
	for v, b in pairs(weapon) do
	  	if not weapons_legal[v] then
			table.insert(ilegal_log,v)
			ilegal = true 
	  	end
	end
	if ilegal then
		zero.giveWeapons(weapons_legal, true, GlobalState.weaponToken)
		weapon = weapons_legal
		zeroServer.weaponsChecker(ilegal_log)						 
	end
	return weapon
end	

zero.setArmour = function(amount)
	--SetPedArmour(PlayerPedId(),amount)
	TriggerEvent('carrinho', amount)
end

zero.getArmour = function()
	return GetPedArmour(PlayerPedId())
end

local parse_part = function(key)
	if type(key) == "string" and string.sub(key,1,1) == "p" then
		return true,tonumber(string.sub(key,2))
	else
		return false,tonumber(key)
	end
end

zero.getDrawables = function(part)
	local isprop, index = parse_part(part)
	if isprop then
		return GetNumberOfPedPropDrawableVariations(PlayerPedId(),index)
	else
		return GetNumberOfPedDrawableVariations(PlayerPedId(),index)
	end
end

zero.getDrawableTextures = function(part,drawable)
	local isprop, index = parse_part(part)
	if isprop then
		return GetNumberOfPedPropTextureVariations(PlayerPedId(),index,drawable)
	else
		return GetNumberOfPedTextureVariations(PlayerPedId(),index,drawable)
	end
end

zero.getCustomization = function()
	local ped = PlayerPedId()
	local custom = {}
	custom.modelhash = GetEntityModel(ped)

	for i = 0,20 do
		custom[i] = { GetPedDrawableVariation(ped,i),GetPedTextureVariation(ped,i),GetPedPaletteVariation(ped,i) }
	end

	for i = 0,10 do
		custom["p"..i] = { GetPedPropIndex(ped,i),math.max(GetPedPropTextureIndex(ped,i),0) }
	end
	return custom
end

zero.setCustomization = function(custom)
	local r = async()
	Citizen.CreateThread(function()
		if custom then
			local ped = PlayerPedId()
			local mhash = nil

			if custom.modelhash then
				mhash = custom.modelhash
			elseif custom.model then
				mhash = GetHashKey(custom.model)
			end

			if mhash then
                local i = 0
                while not HasModelLoaded(mhash) and i < 10000 do
                    i = i + 1
                    RequestModel(mhash)
                    Citizen.Wait(10)
                end

                if HasModelLoaded(mhash) then
                    local weapons = zero.getWeapons()
                    local armour = zero.getArmour()
                    local health = zero.getHealth()

                    SetPlayerModel(PlayerId(),mhash)
                    zero.setHealth(health)
                    zero.giveWeapons(weapons,true,GlobalState.weaponToken)
                    zero.setArmour(armour)
                    SetModelAsNoLongerNeeded(mhash)
                end
            end

			ped = PlayerPedId()
			SetPedMaxHealth(ped,400)

			for k,v in pairs(custom) do
				if k ~= "model" and k ~= "modelhash" then
					local isprop, index = parse_part(k)
					if isprop then
						if v[1] < 0 then
							ClearPedProp(ped,index)
						else
							SetPedPropIndex(ped,index,v[1],v[2],v[3] or 2)
						end
					else
						SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
					end
				end
			end
			TriggerEvent("nyoModule:barberUpdate")
			TriggerEvent("nyoModule:tattooUpdate")
			TriggerServerEvent('zero_whitelist:server')
		end
		r()
	end)
	return r:wait()
end