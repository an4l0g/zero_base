cIdentity = {}

RegisterKeyMapping('openIdentity', 'Abrir identidade', 'keyboard', 'F11')
RegisterCommand('openIdentity', function()
    SetNuiFocus(true, true)
    cIdentity.updateNui()
end)

cIdentity.updateNui = function()
    SendNUIMessage({
        action = 'open',
        userInfo = {
            id = 1,
            fullname = 'An4log Fodase',
            image = 'https://media.discordapp.net/attachments/1059878373737893918/1129469593002446958/image.png?width=408&height=492', -- Ou nulo
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