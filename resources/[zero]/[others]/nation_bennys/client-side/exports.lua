local hasNeonKit = function(veh)
	for i = 0, 3 do 
		if (not IsVehicleNeonLightEnabled(veh, i)) then return false; end;
	end 
	return true
end

local rgbToHex = function(rgb)
	local hexadecimal = '#'
	for key, value in pairs(rgb) do
		local hex = ''

		while(value > 0)do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex			
		end

		if (string.len(hex) == 0) then
			hex = '00'
		elseif (string.len(hex) == 1) then
			hex = '0' .. hex
		end
		hexadecimal = hexadecimal .. hex
	end
	return hexadecimal
end

local getColorType = function(color)
	for k, v in pairs(colors) do
		for i, j in pairs(v) do
			if (j == color) then return k; end;
		end
	end
	return false
end

local isWheelType = function(type)
	local type = wheeltype[type]
	local bool = false
	local wheel = 0
	local num = 0
	local wtype = GetVehicleWheelType(vehicle)
	if (wtype == type) then
		bool = true
		wheel = rodaatual
	end
	SetVehicleWheelType(vehicle,type)
	num = GetNumVehicleMods(vehicle,mod['dianteira'])
	SetVehicleWheelType(vehicle,wtype)
	return bool, wheel, num
end

getAllVehicleMods = function(veh)
	local myVehicle = {}
	myVehicle.vehicle = veh
	myVehicle.model = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
	myVehicle.color = table.pack(GetVehicleColours(veh))
	myVehicle.customPcolor = table.pack(GetVehicleCustomPrimaryColour(veh))
	myVehicle.customScolor = table.pack(GetVehicleCustomSecondaryColour(veh))
	myVehicle.extracolor = table.pack(GetVehicleExtraColours(veh))
	myVehicle.neon = hasNeonKit(veh)
	myVehicle.neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
	myVehicle.xenoncolor = GetVehicleHeadlightsColour(veh)
	myVehicle.smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
	myVehicle.plateindex = GetVehicleNumberPlateTextIndex(veh)
	myVehicle.pcolortype = getColorType(myVehicle.color[1])
	myVehicle.scolortype = getColorType(myVehicle.color[2])
	
	myVehicle.mods = {}
	for i = 0, 48 do
		myVehicle.mods[i] = { mod = nil }
	end

	for i, t in pairs(myVehicle.mods) do
		if (i == 22 or i == 18) then
			if (IsToggleModOn(veh, i)) then t.mod = 1
			else t.mod = 0 end
		elseif (i == 23 or i == 24) then
			t.mod = GetVehicleMod(veh,i)
			t.variation = GetVehicleModVariation(veh, i)
		else
			t.mod = GetVehicleMod(veh,i)
		end
	end

	if (GetVehicleWindowTint(veh) == -1 or GetVehicleWindowTint(veh) == 0) then
		myVehicle.windowtint = false
	else
		myVehicle.windowtint = GetVehicleWindowTint(veh)
	end
	
	if (myVehicle.xenoncolor > 12 or myVehicle.xenoncolor < -1) then myVehicle.xenoncolor = -1; end;

	myVehicle.wheeltype = GetVehicleWheelType(veh)
	myVehicle.bulletProofTyres = GetVehicleTyresCanBurst(veh)
	myVehicle.damage = ((1000 - GetVehicleBodyHealth(vehicle)) / 100)
	return myVehicle
end
exports('getAllVehicleMods', getAllVehicleMods)

getVehicleMods = function(veh)
	local mods = {
		['cor-primaria'] = rgbToHex({ GetVehicleCustomPrimaryColour(veh) }),
		['cor-secundaria'] = rgbToHex({ GetVehicleCustomSecondaryColour(veh) }),
		['neon'] = IsVehicleNeonLightEnabled(veh, 2),
		['neon-colors'] = rgbToHex({ GetVehicleNeonLightsColour(veh) }),
		['smoke-colors'] = rgbToHex({ GetVehicleTyreSmokeColor(veh) }),
		['custom-pneus'] = GetVehicleModVariation(veh, mod['dianteira']),
		['bulletproof-pneus'] = GetVehicleTyresCanBurst(veh),
		['farol'] = IsToggleModOn(veh, mod['farol']),
		['turbo'] = IsToggleModOn(veh, mod['turbo']),
		['placa'] = { 6, (GetVehicleNumberPlateTextIndex(veh) - 1) },
		['vidro'] = { 7, (GetVehicleWindowTint(veh) - 1) },
		['bike'] = IsThisModelABike(GetEntityModel(veh)),
	}

	rodaatual = GetVehicleMod(veh, mod['dianteira'])
	
	for k in pairs(wheeltype) do mods[k] = { isWheelType(k) }; end;

	SetVehicleMod(veh, mod['dianteira'], rodaatual)
	
	for k in pairs(mod) do
		if (mods[k] == nil) then
			mods[k] = { (GetNumVehicleMods(veh, mod[k]) + 1), GetVehicleMod(veh, mod[k]) }
		end
	end
	return mods
end
exports('getVehicleMods', getVehicleMods)

setVehicleMods = function(veh, myVeh, tunnerChip)
	SetVehicleModKit(veh,0)
	if (not myVeh or not myVeh.customPcolor) then return; end;
	local bug = false
	local primary = myVeh.color[1]
	local secondary = myVeh.color[2]
	local cprimary = myVeh.customPcolor
	if (cprimary['1']) then bug = true; end;
	local csecondary = myVeh.customScolor
	local perolado = myVeh.extracolor[1]
	local wheelcolor = myVeh.extracolor[2]
	local neoncolor = myVeh.neoncolor
	local smokecolor = myVeh.smokecolor
	ClearVehicleCustomPrimaryColour(veh)
	ClearVehicleCustomSecondaryColour(veh)
	SetVehicleWheelType(veh,myVeh.wheeltype)
	SetVehicleColours(veh,primary,secondary)
	if (bug) then
		SetVehicleCustomPrimaryColour(veh,cprimary['1'],cprimary['2'],cprimary['3'])
		SetVehicleCustomSecondaryColour(veh,csecondary['1'],csecondary['2'],csecondary['3'])
	else
		SetVehicleCustomPrimaryColour(veh,cprimary[1],cprimary[2],cprimary[3])
		SetVehicleCustomSecondaryColour(veh,csecondary[1],csecondary[2],csecondary[3])
	end
	SetVehicleExtraColours(veh,perolado,wheelcolor)
	SetVehicleNeonLightsColour(veh,neoncolor[1],neoncolor[2],neoncolor[3])
	SetVehicleXenonLightsColour(veh,myVeh.xenoncolor)
	SetVehicleNumberPlateTextIndex(veh,myVeh.plateindex)
	SetVehicleWindowTint(veh,myVeh.windowtint)
	for i,t in pairs(myVeh.mods) do 
		if tonumber(i) == 22 or tonumber(i) == 18 then
			if t.mod > 0 then
				ToggleVehicleMod(veh,tonumber(i),true)
			else
				ToggleVehicleMod(veh,tonumber(i),false)
			end
		elseif tonumber(i) == 20 then
			smokeColor(veh,smokecolor)
		elseif tonumber(i) == 23 or tonumber(i) == 24 then
			SetVehicleMod(veh,tonumber(i),tonumber(t.mod),tonumber(t.variation))
		else
			SetVehicleMod(veh,tonumber(i),tonumber(t.mod))
		end
	end
	SetVehicleTyresCanBurst(veh,myVeh.bulletProofTyres)
	if myVeh.neon then
		for i = 0, 3 do
			SetVehicleNeonLightEnabled(veh,i,true)
		end
	else
		for i = 0, 3 do
			SetVehicleNeonLightEnabled(veh,i,false)
		end
	end
	if myVeh.damage > 0 then
		SetVehicleBodyHealth(veh,myVeh.damage)
	end
end
exports('setVehicleMods', setVehicleMods)