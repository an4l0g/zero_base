RegisterKeyMapping('openIdentity', 'Abrir identidade', 'keyboard', 'F11')
RegisterCommand('openIdentity', function()
    SetNuiFocus(true, true)
    cIdentity.updateNui()
end)

cIdentity.updateNui = function()
    SendNuiMessage({
        action = 'open',
        userInfo = {
            id = 1,
            fullname = 'An4log Fodase',
            image = 'https://media.discordapp.net/attachments/1059878373737893918/1129469593002446958/image.png?width=408&height=492',
            job = '[Hospital] Diretor',
            rg = 'ME0851PZ',
            wallet = 1233213,
            bank = 1231231233323,
            coins = 321,
            staff = 'Owner',
            age = 25,
            phone = '123-123',
            vip = 'ZERO',
            relationship = 'Casado',
            driveLicense = 'A/B',
            flightLicense = true,
            gunLicense = true,
            fines = 12332123,
            rh = 'A+'
        }
    })
end