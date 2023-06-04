local vSERVER = Tunnel.getInterface('skinShop')

local locsConfig = config.locsSkinShop
local generalConfig =  config.generalSkinShop

local inSkinShop = false
local nearestBlip = {}

mainThread = function()
    local getNearestSkinShops = function()
        while true do
            if (not inSkinShop and not inMenu) then
                local pedCoords = GetEntityCoords(PlayerPedId())
                if (nearestBlip) and nearestBlip['coord'] then
                    local distance = #(pedCoords - nearestBlip['coord'].xyz)
                    if (distance >= 6.0) then
                        nearestBlip = false
                    elseif (distance <= 1.2) then
                        nearestBlip['close'] = true
                    else
                        nearestBlip['close'] = false
                    end
                else
                    for k, v in pairs(locsConfig) do
                        local distance = #(pedCoords - v['coord'].xyz)
                        if (distance <= 5.0) then
                            nearestBlip = locsConfig[k]
                        end
                    end
                end
            end
            Citizen.Wait(500)
        end
    end

    CreateThread(getNearestSkinShops)
    addBlips(locsConfig)

    while true do
        local idle = 500
        local ped = PlayerPedId()
        if (not inSkinShop and not inMenu) then
            if (nearestBlip) and nearestBlip['coord'] then
                idle = 4
                DrawText3D(nearestBlip['coord'].x, nearestBlip['coord'].y, nearestBlip['coord'].z+0.5, '~b~[E]~w~ - Loja de Roupas')
                if (IsControlJustPressed(0, 38) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped)) then
                    openSkinShop(generalConfig[nearestBlip['config']], nearestBlip['coord'].xyz, nearestBlip['coord'].w)
                end
            end
        end
        Citizen.Wait(idle)
    end
end

CreateThread(mainThread)

local oldCustom = {}
local configShop = {}
local categoryVariation = 1
local categoryProp = 'p1'
local color = 0
local value = 0
local totalValue = 0
local shopConfig = {
    parts = {
        mascara = 1,
        mao = 3,
        calca = 4,
        mochila = 5,
        sapato = 6,
        gravata = 7,
        camisa = 8,
        colete = 9,
        decals = 10,
        jaqueta = 11,
        bone = 'p0',
        oculos = 'p1',
        brinco = 'p2',
        relogio = 'p6',
        bracelete = 'p7',
        outfit = 'outfit'
    },
    
    carroCompras = {
        mascara = false,
        mao = false,
        calca = false,
        mochila = false,
        sapato = false,
        gravata = false,
        camisa = false,
        colete = false,
        decals = false,
        jaqueta = false,
        bone = false,
        oculos = false,
        brinco = false,
        relogio = false,
        bracelete = false
    },

    old = {

    }
}

local updateSkinCompras = function()
    value = 0 
    for index, value in pairs(shopConfig['carroCompras']) do
        if (shopConfig['carroCompras'][index] == true) then
            local amount = configShop[index]['price']
            value = (value + amount)
        end
    end
    totalValue = value
    return value
end

local getSkinShopDrawables = function(part)
    local ped = PlayerPedId()
    local isProp, index = parsePart(part)
    if (isProp) then
        return GetNumberOfPedPropDrawableVariations(ped, index)
    else
        return GetNumberOfPedDrawableVariations(ped, index)
    end
end

local changeSkinShopClothes = function(dados, tipo, cor)
    local ped = PlayerPedId()
    local isProp, index = parsePart(dados)
    if (isProp) then 
        if (tipo == -1) then 
            ClearPedProp(ped, index)
        else      
            SetPedPropIndex(ped, index, tipo, cor, 1)
        end  
    else 
        SetPedComponentVariation(ped, index, tipo, cor, 1)
    end
    
    custom = getCustomization()
    custom.modelhash = nil

    aux = oldCustom[dados]
    v = custom[dados]

    if (v[1] ~= aux[1] and shopConfig['old'][dados] ~= 'custom') then shopConfig['carroCompras'][dados] = true; shopConfig['old'][dados] = 'custom'; end
    if (v[1] == aux[1] and shopConfig['old'][dados] == 'custom') then shopConfig['carroCompras'][dados] = false; shopConfig['old'][dados] = '0'; end

    price = updateSkinCompras()
    SendNUIMessage({ action = 'updateSkinShopPrice', value = price })
end

local shopProvador = function() 
    Citizen.CreateThread(function()
        while (inSkinShop) do
            DisableControlAction(1, 1, true)
            DisableControlAction(1, 2, true)
            DisableControlAction(1, 24, true)
            DisablePlayerFiring(PlayerPedId(), true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 106, true)
            DisableControlAction(1, 37, true)
            Citizen.Wait(4)
        end
    end)
end

local closeNuiShop = function(reset)
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    SetNuiFocus(false, false)
    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, false)
    setPlayersVisible(false)
    DeleteCam()

    if (DoesCamExist(cam)) then RenderScriptCams(false, false, 0, 1, 0); DestroyCam(cam, false); end

    shopConfig['carroCompras'] = {
        mascara = false,
        mao = false,
        calca = false,
        mochila = false,
        sapato = false,
        gravata = false,
        camisa = false,
        colete = false,
        decals = false,
        jaqueta = false,
        bone = false,
        oculos = false,
        brinco = false,
        relogio = false,
        bracelete = false
    }

    shopConfig['old'] = {}

    if (reset) then setCustomization(oldCustom); end

    inSkinShop = false
    inMenu = false
    oldCustom = {}
    configShop = {}
    value = 0
    totalValue = 0
end

local openNuiShop = function(config, _oldCustom)
    local ped = PlayerPedId()
    SetNuiFocus(true, true)

    local pedModel = GetEntityModel(ped)
    local sex = ''
    local prefix = ''
    if (pedModel == GetHashKey('mp_m_freemode_01')) then
        sex = 'Male'; prefix = 'M';
    elseif (pedModel == GetHashKey('mp_f_freemode_01')) then
        sex = 'Female'; prefix = 'F';
    else
        local customPeds = config['customPeds']
        if (customPeds) then
            local allowed = customPeds[pedModel]
            if (allowed) then
                if type(allowed) == 'string' then
                    sex = allowed
                    prefix = allowed:sub(1,1)
                else
                    sex = 'Male'
                    prefix = 'M'
                end
            end
        end
    end

    drawVariations = getSkinShopDrawables(categoryVariation)
    drawProps = getSkinShopDrawables(categoryProp)
    
    SendNUIMessage({ 
        method = 'openSkinShop', 
        data = {
            type = config['shopType'], 
            config = config['shopConfig'], 
            oldCustom = _oldCustom, 
            sex = sex, 
            prefix = prefix, 
            drawVariations = drawVariations, 
            categoryVariation = categoryVariation, 
            drawProps = drawProps, 
            categoryProp = categoryProp 
        }
    })

    SetCameraCoords('all', true)
end

openSkinShop = function(config, coords, heading)
    local ped = PlayerPedId()
    inMenu = true
    inSkinShop = true
    value = 0
    totalValue = 0
    oldCustom = getCustomization()
    configShop = config['shopConfig']

    shopProvador()
    color = 0

    if (config['hidePlayers']) then setPlayersVisible(true); end;

    SetEntityCoords(ped, coords)
    SetEntityHeading(ped, heading)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, true)
    IsEntityStatic(ped)

    openNuiShop(config, oldCustom)
end

RegisterNUICallback('changeSkinShopMenuColor', function(data, cb)
    local ped = PlayerPedId()

    local dPart = data.part;
    local dId = data.itemId;
    local menu = data.menu;
    
    local isProp, index = parsePart(dPart)
    if (isProp) then 
        max = GetNumberOfPedPropTextureVariations(ped, index, dId)
    else 
        max = GetNumberOfPedTextureVariations(ped, index, dId)
    end

    if (data.menuChange) then 
        SendNUIMessage({
            action = 'updateSkinShopColor',
            menu = menu,
            drawa = max,
            roupaId = dId
        })
    end 

    local change = data.change;
    if (change and change ~= 0) then changeSkinShopClothes(dPart, dId, data.color); end
end)

RegisterNUICallback('changeSkinShopPart', function(data,cb)
    -- local newPart = ''
    -- local menu = data.menu
    -- if menu == 'D' then
    --     dataPartD = shopConfig.parts[data.part]
    --     newPart = dataPartD
    -- elseif menu == 'E' then 
    --     dataPartE = shopConfig.parts[data.part]
    --     newPart = dataPartE
    -- end
    
    -- NyoModulesClient.sendNUIMessage('updateSkinShop', {
    --     newPart = newPart,
    --     drawa = getSkinShopDrawables(newPart),
    --     menu = menu
    -- })
    -- cb({})
end)

RegisterNUICallback('closeSkinShop', function(data)
    closeNuiShop(false)
end)

RegisterNUICallback('paymentSkinShop', function(data)
    local sucess = vSERVER.tryPayment(totalValue, getCustomization())
    closeNuiShop(not sucess)
end)