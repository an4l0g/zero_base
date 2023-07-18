cIdentity = {}

RegisterKeyMapping('openIdentity', 'Abrir identidade', 'keyboard', 'F11')
RegisterCommand('openIdentity', function()
    SetNuiFocus(true, true)
    cIdentity.updateNui()
end)

cIdentity.updateNui = function()
    local infos = vSERVER.getUserIdentity()
    SendNUIMessage({
        action = 'open',
        userInfo = {
            id = 1,
            fullname = 'An4log Fodase',
            image = 'https://cdn.discordapp.com/attachments/922885255386517535/1128411705173627060/k1ZAtQdPi240HwV0A5CZgx4aftxdZUfgl8NaNraL.png', -- Ou nulo
            job = '[Hospital] Diretor', -- Ou nulo
            rg = 'ME0851PZ',
            wallet = 1233213,
            bank = 1231231233323,
            coins = 321,
            staff = 'Owner', -- Ou nulo
            age = 25,
            phone = '123-123',
            vip = 'ZERO', -- Ou nulo
            relationship = 'Casado',  -- Ou nulo
            driveLicense = 'A/B',  -- Ou nulo
            flightLicense = true, -- Ou nulo
            gunLicense = true, -- Ou nulo
            fines = 12332123, 
            rh = 'A+' -- Ou nulo
        }
    })
end

RegisterNuiCallback('close', function()
    print('teste')
    SetNuiFocus(false, false)
end)

RegisterNuiCallback('changeImage', function(data)
    -- Trocar imagem do cara pelo banco de dados
    print('Image', data.image)
    cIdentity.updateNui()
end)