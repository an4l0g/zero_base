-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("zero","lib/Tunnel")
local Proxy = module("zero","lib/Proxy")
vRP = Proxy.getInterface("zero")

nyoBSServer = Tunnel.getInterface("nyo_barbershop")
nyoBSClient = {}
Tunnel.bindInterface("nyo_barbershop",nyoBSClient)


---------------------------------------------------------------------------
--- | Variaveis [1] 
----------------------------------------------------------------------------

local barberShops = {
	{ name = "Barbearia", x = -815.59, y = -182.16, z = 37.66, provador = {x = -815.59, y = -182.16, z = 37.66, heading = 212.26}},
	{ name = "Barbearia", x = 136.97, y = -1711.19, z = 29.31, provador = {x = 136.97, y = -1711.19, z = 29.31, heading = 58.26}},
	{ name = "Barbearia", x = -1282.00, y = -1118.86, z = 7.00, provador = {x = -1282.00, y = -1118.86, z = 7.00, heading = 7.00}},
	{ name = "Barbearia", x = 1934.11, y = 3730.73, z = 32.85, provador = {x = 1934.11, y = 3730.73, z = 32.85, heading = 124.95}},
	{ name = "Barbearia", x = 1211.07, y = -475.00, z = 66.31, provador = {x = 1211.07, y = -475.00, z = 66.31, heading = 345.26}},
	{ name = "Barbearia", x = -34.97, y = -150.90, z = 57.18, provador = {x = -34.97, y = -150.90, z = 57.18, heading = 250.26}},
	{ name = "Barbearia", x = -280.37, y = 6227.01, z = 31.70, provador = {x = -280.37, y = 6227.01, z = 31.70, heading = 321.81}},
}


local old_custom = {}
local nCustom = {}
local noProvador = false;
local precoTotal = 0;
local valor = 0;
local cooldown = 0;
local in_loja = false
local dataPart = 12

local oldC = nil 
local old = {
	["0"] = 0,
	["9"] = 0,
	["8"] = 0,
	["10"] = 0,
	["12"] = 0,
	["13"] = 0,
	["6"] = 0,
	["5"] = 0,
	["4"] = 0,
	["3"] = 0,
	["2"] = 0,
	["1"] = 0,
}

local carroCompras = {
	["0"] = false,
	["9"] = false,
	["8"] = false,
	["10"] = false,
	["12"] = false,
	["13"] = false,
	["6"] = false,
	["5"] = false,
	["4"] = false,
	["3"] = false,
	["2"] = false,
	["1"] = false,
}


function f(n)
	n = n + 0.00000
	return n
end


local canStartTread = false
local currentCharacterMode = { fathersID = 0, mothersID = 0, skinColor = 0, shapeMix = 0.0,
            eyesColor = 0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0,
            noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0,
            cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0,
            jawHeight = 0, chinLength = 0, chinPosition = 0,
            chinWidth = 0, chinShape = 0, neckWidth = 0,
            hairModel = 4, firstHairColor = 0, secondHairColor = 0, eyebrowsModel = 0, eyebrowsColor = 0,
            beardModel = -1, beardColor = 0, chestModel = -1, chestColor = 0, blushModel = -1, blushColor = 0, lipstickModel = -1, lipstickColor = 0,
            blemishesModel = -1, ageingModel = -1, complexionModel = -1, sundamageModel = -1, frecklesModel = -1, makeupModel = -1 }

custom = currentCharacterMode

local parts = {
	["Defeitos"] = 0,
	["Barba"] = 1,
	["Sobrancelhas"] = 2,
	["Envelhecimento"] = 3,
	["Maquiagem"] = 4,
	["Blush"] = 5,
	["Rugas"] = 6,
	["Batom"] = 8,
	["Sardas"] = 9,
	["Cabelo no Peito"] = 10,
	["Manchas no Corpo"] = 11,
	["Cabelo"] = 12,
	["Cor Sec. do Cabelo"] = 13
}


---------------------------------
-- | BarbarShop Threads e Functions [1]
---------------------------------

CreateThread(function()
    criarBlip()
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped, true)
        
		for k, v in pairs(barberShops) do
            local provador = barberShops[k].provador
            if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, barberShops[k].x, barberShops[k].y, barberShops[k].z, true ) <= 8 and not in_loja and (cooldown == 0) then
                sleep = 4
                DrawMarker(27,barberShops[k].x,barberShops[k].y,barberShops[k].z-1,0,0,0,0,180.0,130.0,1.0,1.0,1.0,255,0,0,75,0,0,0,1)
               -- DrawText3D(lojaderoupa[k].x, lojaderoupa[k].y, lojaderoupa[k].z-0.1, "~b~[Loja de Roupas]\n~w~Pressione ~g~[E]~w~ para acessar a loja")
            end

            if GetDistanceBetweenCoords(GetEntityCoords(ped), barberShops[k].x, barberShops[k].y, barberShops[k].z, true ) < 1 then
                if IsControlJustPressed(0, 38) and not nyoBSServer.checkProcurado()  then

                    valor = 0
                    precoTotal = 0
                    noProvador = true
                    -- old_custom = vRP.getCustomization()
                    -- Citizen.Wait(40)
                    -- nCustom = old_custom

                    lojaProvador()


                    TaskGoToCoordAnyMeans(ped, provador.x, provador.y, provador.z, 1.0, 0, 0, 786603, 0xbf800000)
                end
            end

            if noProvador then
                if GetDistanceBetweenCoords(GetEntityCoords(ped), provador.x, provador.y, provador.z, true ) < 0.5 and not chegou then
                    chegou = true

                    valor = 0
                    precoTotal = 0
                    SetEntityHeading(PlayerPedId(), provador.heading)
                    FreezeEntityPosition(ped, true)
                    SetEntityInvincible(ped, false) --MQCU
                    openGuiBarberShop()
                end
            end
        end
        Citizen.Wait(sleep)
    end
end)

function openGuiBarberShop()
	local ped = PlayerPedId()
	SetNuiFocus(true, true)
	for k,v in pairs(custom) do
		old_custom[k] = v
	end
	oldC = nyoBSClient.getOverlay()
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SendNUIMessage({ 
            openBarberShop = true, 
            sexo = "Male", prefix = "M", dataPart = dataPart, oldCustom = oldC
		})
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then 
        SendNUIMessage({ 
            openBarberShop = true, 
            sexo = "Female", prefix = "F", dataPart = dataPart, oldCustom = oldC
        })
    end
	in_loja = true
end

function lojaProvador() 
    Citizen.CreateThread(function()
        while true do
            if noProvador then
              --  PlayerInstancia()
                DisableControlAction(1, 1, true)
                DisableControlAction(1, 2, true)
                DisableControlAction(1, 24, true)
                DisablePlayerFiring(PlayerPedId(), true)
                DisableControlAction(1, 142, true)
                DisableControlAction(1, 106, true)
                DisableControlAction(1, 37, true)
            else 
                break
            end
            Citizen.Wait(4)
        end
    end)
end


function closeGuiBarberShop()
    local ped = PlayerPedId()
    --DeleteCam()
    SetNuiFocus(false, false)
    SendNUIMessage({ openBarberShop = false })
    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, false)
    --PlayerReturnInstancia()
    --SendNUIMessage({ action = "setPrice", price = 0, typeaction = "remove" })
    
    in_loja = false
    noProvador = false
	chegou = false
	
	old = {
		["0"] = 0,
		["9"] = 0,
		["8"] = 0,
		["10"] = 0,
		["12"] = 0,
		["13"] = 0,
		["6"] = 0,
		["5"] = 0,
		["4"] = 0,
		["3"] = 0,
		["2"] = 0,
		["1"] = 0,
	}
	
	carroCompras = {
		["0"] = false,
		["9"] = false,
		["8"] = false,
		["10"] = false,
		["12"] = false,
		["13"] = false,
		["6"] = false,
		["5"] = false,
		["4"] = false,
		["3"] = false,
		["2"] = false,
		["1"] = false,
	}
end 



RegisterNUICallback("reset", function(data, cb)
	custom = old_custom
	old_custom = {}
    closeGuiBarberShop()
    ClearPedTasks(PlayerPedId())
end)

RegisterNUICallback("updateGui", function(data, cb)
	local ped = PlayerPedId()
	dataPart = parseInt(data.part)
	local gDrawables = nyoBSClient.getDrawables(dataPart)
	local gTextures = nyoBSClient.getTextures(dataPart)
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SendNUIMessage({ updateBarberShop = true, prefix = "M", drawable = gDrawables, textures = gTextures })
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then 
			SendNUIMessage({ updateBarberShop = true, prefix = "F", drawable = gDrawables, textures = gTextures })
    end
	
end)

RegisterNUICallback("changeCustom", function(data, cb)
	local type = parseInt(data.type)

	if parseInt(data.id) ~= oldC[tostring(type)][1] and old[tostring(type)] ~= "custom" then 
		carroCompras[tostring(type)] = true
		price = updateCarroCompras()
		SendNUIMessage({ action = "setPrice", price = price, typeaction = "add" })
		old[tostring(type)] = "custom"
	end

	if parseInt(data.id) == oldC[tostring(type)][1] and old[tostring(type)] == "custom" then 
		carroCompras[tostring(type)] = false
		price = updateCarroCompras()
		SendNUIMessage({ action = "setPrice", price = price, typeaction = "remove" })
		old[tostring(type)] = "0"
	end


	if type == 1 then -- Barba
		custom.beardModel = parseInt(data.id)
	elseif type == 2 then --Sobrancelhas
		custom.eyebrowsModel = parseInt(data.id)
	elseif type == 3 then -- Envelhecimento
		custom.ageingModel = parseInt(data.id)
	elseif type == 4 then --Maquiagem
		custom.makeupModel = parseInt(data.id)	
	elseif type == 5 then -- Blush 
		custom.blushModel = parseInt(data.id)
	elseif type == 6 then -- Rugas 
		custom.complexionModel = parseInt(data.id)
	elseif(type == 8) then --Batom
		custom.lipstickModel = parseInt(data.id)
	elseif(type == 9) then -- Sardas 
		custom.frecklesModel = parseInt(data.id)
	elseif(type == 10) then -- Cabelo do Peito 
		custom.chestModel = parseInt(data.id)
	elseif type == 12 then -- Cabelo
		custom.hairModel = parseInt(data.id)
	end
	TaskUpdateSkinOptions()
	TaskUpdateFaceOptions()
	TaskUpdateHeadOptions()
    --changeClothe(data.type, data.id, data.color)
end)

RegisterNUICallback("changeColor", function(data, cb)
	local dataType = parseInt(data.dataType)
	local type = parseInt(data.type)
	if dataType == 1 or dataType == 2 or dataType == 5 or dataType == 8 or dataType == 10 then 
		if type == 1 then 
			if dataType == 1 then 				
				custom.beardColor = parseInt(data.color)
			elseif dataType == 2 then 
				custom.eyebrowsColor = parseInt(data.color)
			elseif dataType == 5 then 
				custom.blushColor = parseInt(data.color)
			elseif dataType == 8 then 
				custom.lipstickColor = parseInt(data.color)
			elseif dataType == 10 then 
				custom.chestColor = parseInt(data.calor) 
			end
		end
	elseif dataType == 12 then 
		if type == 1 then 			
			custom.firstHairColor = parseInt(data.color)
		else			
			custom.secondHairColor = parseInt(data.color)
		end
	end
	TaskUpdateSkinOptions()
	TaskUpdateFaceOptions()
	TaskUpdateHeadOptions()
    --changeClothe(data.type, data.id, data.color)
end)

RegisterNUICallback("leftHeading", function(data, cb)
    local currentHeading = GetEntityHeading(PlayerPedId())
    heading = currentHeading-tonumber(data.value)
    SetEntityHeading(PlayerPedId(), heading)
end)

RegisterNUICallback("rightHeading", function(data, cb)
    local currentHeading = GetEntityHeading(PlayerPedId())
    heading = currentHeading+tonumber(data.value)
    SetEntityHeading(PlayerPedId(), heading)
end)


RegisterNUICallback("payament", function(data, cb)
	local ped = PlayerPedId()
	SetNuiFocus(false, false)
	old = {
		["0"] = 0,
		["9"] = 0,
		["8"] = 0,
		["10"] = 0,
		["12"] = 0,
		["13"] = 0,
		["6"] = 0,
		["5"] = 0,
		["4"] = 0,
		["3"] = 0,
		["2"] = 0,
		["1"] = 0,
	}
	
	carroCompras = {
		["0"] = false,
		["9"] = false,
		["8"] = false,
		["10"] = false,
		["12"] = false,
		["13"] = false,
		["6"] = false,
		["5"] = false,
		["4"] = false,
		["3"] = false,
		["2"] = false,
		["1"] = false,
	}
	nyoBSServer.checkout(tonumber(data.price), json.encode(custom))
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, false)
    in_loja = false
    noProvador = false
	chegou = false
   -- TriggerServerEvent("LojaDeRoupas:Comprar", tonumber(data.price), json.encode(data.parts)) 
end)

function nyoBSClient.resetBuy()
	local ped = PlayerPedId()
	custom = old_custom
	old_custom = {}
	ClearPedTasks(PlayerPedId())
	TaskUpdateSkinOptions()
	TaskUpdateFaceOptions()
	TaskUpdateHeadOptions()
	FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, false)    
    in_loja = false
    noProvador = false
	chegou = false
end


function updateCarroCompras()
    valor = 0
    for k, v in pairs(carroCompras) do
        if carroCompras[k] == true then
            valor = valor + 500
        end
    end
    precoTotal = valor
    return valor
end
-------------------
-- | SETS [1]
------------------

function nyoBSClient.setCharacter(data)
	if data then
		custom = data
		canStartTread = true
	end
end

function nyoBSClient.getCharacter()
	return custom
end

function nyoBSClient.setOverlay(data)
	if data then
		custom.blemishesModel = data["0"][1]
		custom.frecklesModel = data["9"][1]
		custom.lipstickModel = data["8"][1]
		custom.lipstickColor = data["8"][2]
		custom.chestModel = data["10"][1]
		custom.chestColor = data["10"][2]
		custom.hairModel = data["12"][1]
		custom.firstHairColor = data["12"][2]
		custom.secondHairColor = data["13"][2]
		custom.complexionModel = data["6"][1]
		custom.blushModel = data["5"][1]
		custom.blushColor = data["5"][2]
		custom.makeupModel = data["4"][1]
		custom.ageingModel = data["3"][1]
		custom.eyebrowsModel = data["2"][1]
		custom.eyebrowsColor = data["2"][2]
		custom.beardModel = data["1"][1]
		custom.beardColor = data["1"][2]
	end
end

function nyoBSClient.resetOverlay()
	custom.blemishesModel = currentCharacterMode.blemishesModel
	custom.frecklesModel = currentCharacterMode.frecklesModel
	custom.lipstickModel = currentCharacterMode.lipstickModel
	custom.lipstickColor = currentCharacterMode.lipstickColor
	custom.chestModel = currentCharacterMode.chestModel
	custom.chestColor = currentCharacterMode.chestColor
	custom.hairModel = currentCharacterMode.hairModel
	custom.firstHairColor = currentCharacterMode.firstHairColor
	custom.secondHairColor = currentCharacterMode.secondHairColor
	custom.complexionModel = currentCharacterMode.complexionModel
	custom.blushModel = currentCharacterMode.blushModel
	custom.blushColor = currentCharacterMode.blushColor
	custom.makeupModel = currentCharacterMode.makeupModel
	custom.ageingModel = currentCharacterMode.ageingModel
	custom.eyebrowsModel = currentCharacterMode.eyebrowsModel
	custom.eyebrowsColor = currentCharacterMode.eyebrowsColor
	custom.beardModel = currentCharacterMode.beardModel
	custom.beardColor = currentCharacterMode.beardColor
end

function nyoBSClient.getOverlay()
	local overlay = {
		["0"] = { custom.blemishesModel,0 },
		["9"] = { custom.frecklesModel,0 },
		["8"] = { custom.lipstickModel,custom.lipstickColor },
		["10"] = { custom.chestModel,custom.chestColor },
		["12"] = { custom.hairModel,custom.firstHairColor },
		["13"] = { custom.hairModel,custom.secondHairColor },
		["6"] = { custom.complexionModel,0 },
		["5"] = { custom.blushModel,custom.blushColor },
		["4"] = { custom.makeupModel,0 },
		["3"] = { custom.ageingModel,0 },
		["2"] = { custom.eyebrowsModel,custom.eyebrowsColor },
		["1"] = { custom.beardModel,custom.beardColor }
	}
	return overlay
end

function nyoBSClient.getDrawables(part)
	print(part)
	if part == 12 then
		return tonumber(GetNumberOfPedDrawableVariations(PlayerPedId(),2))
	elseif part == -1 then
		return tonumber(GetNumberOfPedDrawableVariations(PlayerPedId(),0))
	elseif part == -2 then
		return 64
	else
		print('aqui')
		return tonumber(GetNumHeadOverlayValues(part))
	end
end

function nyoBSClient.getTextures(part)
	if part == -1 then
		return tonumber(GetNumHairColors())
	else
		return 64
	end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if canStartTread then
			while not IsPedModel(PlayerPedId(),"mp_m_freemode_01") and not IsPedModel(PlayerPedId(),"mp_f_freemode_01") do
				Citizen.Wait(10)
			end
			if custom then
				TaskUpdateSkinOptions()
				TaskUpdateFaceOptions()
				TaskUpdateHeadOptions()
			end
		end
	end
end)

function TaskUpdateSkinOptions()
	local data = custom
	SetPedHeadBlendData(PlayerPedId(),data.fathersID,data.mothersID,0,data.skinColor,0,0,f(data.shapeMix),0,0,false)
end

function TaskUpdateFaceOptions()
	local ped = PlayerPedId()
	local data = custom	
	-- Olhos
	SetPedEyeColor(ped,data.eyesColor)
	-- Sobrancelha
	SetPedFaceFeature(ped,6,data.eyebrowsHeight)
	SetPedFaceFeature(ped,7,data.eyebrowsWidth)
	-- Nariz
	SetPedFaceFeature(ped,0,data.noseWidth)
	SetPedFaceFeature(ped,1,data.noseHeight)
	SetPedFaceFeature(ped,2,data.noseLength)
	SetPedFaceFeature(ped,3,data.noseBridge)
	SetPedFaceFeature(ped,4,data.noseTip)
	SetPedFaceFeature(ped,5,data.noseShift)
	-- Bochechas
	SetPedFaceFeature(ped,8,data.cheekboneHeight)
	SetPedFaceFeature(ped,9,data.cheekboneWidth)
	SetPedFaceFeature(ped,10,data.cheeksWidth)
	-- Boca/Mandibula
	SetPedFaceFeature(ped,12,data.lips)
	SetPedFaceFeature(ped,13,data.jawWidth)
	SetPedFaceFeature(ped,14,data.jawHeight)
	-- Queixo
	SetPedFaceFeature(ped,15,data.chinLength)
	SetPedFaceFeature(ped,16,data.chinPosition)
	SetPedFaceFeature(ped,17,data.chinWidth)
	SetPedFaceFeature(ped,18,data.chinShape)
	-- Pescoço
	SetPedFaceFeature(ped,19,data.neckWidth)
end

function TaskUpdateHeadOptions()
	local ped = PlayerPedId()
	local data = custom

	-- Cabelo
	SetPedComponentVariation(ped,2,data.hairModel,0,0)
	SetPedHairColor(ped,data.firstHairColor,data.secondHairColor)

	-- Sobrancelha 
	SetPedHeadOverlay(ped,2,data.eyebrowsModel, 0.99)
	SetPedHeadOverlayColor(ped,2,1,data.eyebrowsColor,data.eyebrowsColor)

	-- Barba
	SetPedHeadOverlay(ped,1,data.beardModel,0.99)
	SetPedHeadOverlayColor(ped,1,1,data.beardColor,data.beardColor)

	-- Pelo Corporal
	SetPedHeadOverlay(ped,10,data.chestModel,0.99)
	SetPedHeadOverlayColor(ped,10,1,data.chestColor,data.chestColor)

	-- Blush
	SetPedHeadOverlay(ped,5,data.blushModel,0.4)
	SetPedHeadOverlayColor(ped,5,1,data.blushColor,data.blushColor)

	-- Battom
	SetPedHeadOverlay(ped,8,data.lipstickModel,0.99)
	SetPedHeadOverlayColor(ped,8,1,data.lipstickColor,data.lipstickColor)

	-- Manchas
	SetPedHeadOverlay(ped,0,data.blemishesModel,0.99)
	SetPedHeadOverlayColor(ped,0,0,0,0)

	-- Envelhecimento
	SetPedHeadOverlay(ped,3,data.ageingModel,0.99)
	SetPedHeadOverlayColor(ped,3,0,0,0)

	-- Aspecto
	SetPedHeadOverlay(ped,6,data.complexionModel,0.99)
	SetPedHeadOverlayColor(ped,6,0,0,0)

	-- Pele
	SetPedHeadOverlay(ped,7,data.sundamageModel,0.99)
	SetPedHeadOverlayColor(ped,7,0,0,0)

	-- Sardas
	SetPedHeadOverlay(ped,9,data.frecklesModel,0.99)
	SetPedHeadOverlayColor(ped,9,0,0,0)

	-- Maquiagem
	SetPedHeadOverlay(ped,4,data.makeupModel,0.99)
	SetPedHeadOverlayColor(ped,4,0,0,0)
end



---------------------
-- | Outros [1]
---------------------
function criarBlip()
    for _, item in pairs(barberShops) do
        if item.id then 
            item.blip = AddBlipForCoord(item.x, item.y, item.z)
            SetBlipSprite(item.blip, item.id)
            SetBlipColour(item.blip, item.color)
            SetBlipScale(item.blip, 0.5)
            SetBlipAsShortRange(item.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(item.name)
            EndTextCommandSetBlipName(item.blip)
        end       
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        closeGuiBarberShop()
    end
end)



