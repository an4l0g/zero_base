srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

local configGeneral = config.general

zero._prepare('zero_identity/getUserPhoto', 'select url from identity where user_id = @user_id')
zero._prepare('zero_identity/insertPhoto', 'insert into identity (user_id, url) values (@user_id, @url)')
zero._prepare('zero_identity/updatePhoto', 'update identity set url = @url where user_id = @user_id')

srv.getUserIdentity = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        zero.resetIdentity(user_id)
        
        local table = {}
        table.id = user_id
        table.fullname = getUserFullname(user_id)
        table.image = getUserPhoto(user_id)
        table.job = getUserJob(user_id)
        table.rg = getUserRegistration(user_id)
        table.wallet = zero.getMoney(user_id)
        table.bank = zero.getBankMoney(user_id)
        table.coins = getUserCoins(user_id)
        table.staff = getUserStaff(user_id)
        table.age = getUserAge(user_id)
        table.phone = getUserPhone(user_id)
        table.vip = getUserVip(user_id)
        table.relationship = getUserRelationship(user_id)
        table.driveLicense = getUserDrivelicense(user_id)
        table.flightLicense = nil
        table.gunLicense = getUserGunlicense(user_id)
        table.fines = exports['zero_bank']:verifyMultas(user_id)
        table.rh = getUserRH(user_id)
        return table
    end
end

getUserRG = function(source, nUser, args)
    if (nUser) then
        if (args) then
            local table = {}
            table.id = nUser
            table.fullname = getUserFullname(nUser)
            table.image = getUserPhoto(nUser)
            table.job = getUserJob(nUser)
            table.rg = getUserRegistration(nUser)
            table.wallet = zero.getMoney(nUser)
            table.bank = zero.getBankMoney(nUser)
            table.coins = getUserCoins(nUser)
            table.staff = getUserStaff(nUser)
            table.age = getUserAge(nUser)
            table.phone = getUserPhone(nUser)
            table.vip = getUserVip(nUser)
            table.relationship = getUserRelationship(nUser)
            table.driveLicense = getUserDrivelicense(nUser)
            table.flightLicense = nil
            table.gunLicense = getUserGunlicense(nUser)
            table.fines = exports['zero_bank']:verifyMultas(nUser)
            table.rh = getUserRH(nUser)
            vCLIENT.openNui(source, table)
        else
            local table = {}
            table.id = nUser
            table.fullname = getUserFullname(nUser)
            table.image = getUserPhoto(nUser)
            table.job = nil
            table.rg = getUserRegistration(nUser)
            table.wallet = zero.getMoney(nUser)
            table.bank = nil
            table.coins = nil
            table.staff = nil
            table.age = getUserAge(nUser)
            table.phone = nil
            table.vip = nil
            table.relationship = getUserRelationship(nUser)
            table.driveLicense = getUserDrivelicense(nUser)
            table.flightLicense = nil
            table.gunLicense = getUserGunlicense(nUser)
            table.fines = exports['zero_bank']:verifyMultas(nUser)
            table.rh = getUserRH(nUser)
            zero.webhook('verifyRG', '```prolog\n[ZERO IDENTITY]\n[ACTION]: (VERIFY RG)\n[USER]: '..zero.getUserId(source)..'\n[TARGET]: '..nUser..'\n[TABLE]: '..json.encode(table, { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```'..table.image)
            vCLIENT.openNui(source, table)
        end
    end
end

RegisterCommand('rg', function(source, args)
    local user_id = zero.getUserId(source)
    if (user_id and zero.checkPermissions(user_id, configGeneral.perms)) then
        if (args[1] and zero.hasPermission(user_id, configGeneral.staffPermission)) then
            getUserRG(source, parseInt(args[1]), true)
        else
            local nearestPlayer = zeroClient.getNearestPlayer(source, 2.0)
            if (not nearestPlayer) then return; end;
            
            local request
            if (zeroClient.isHandcuffed(nearestPlayer) or zero.hasPermission(user_id, configGeneral.staffPermission)) then
                request = true
            else
                request = zero.request(nearestPlayer, 'Você deseja passar o seu RG para o policial?', 60000) 
            end

            if (request) then
                local nUser = zero.getUserId(nearestPlayer)
                TriggerClientEvent('notify', source, 'Registro', 'Verificando o <b>RG</b> do passaporte <b>'..nUser..'<b>.', 5000)
                getUserRG(source, nUser)  
            else
                TriggerClientEvent('notify', nearestPlayer, 'Registro', 'Você negou passar o seu <b>RG</b>')
                TriggerClientEvent('notify', source, 'Registro', 'O mesmo negou passar o seu <b>RG</b>.')
            end
        end
    end
end)

srv.updatePhoto = function(image)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        if (image) then
            zero.execute('zero_identity/updatePhoto', { user_id = user_id, url = image })
            zero.webhook('updatePhoto', '```prolog\n[ZERO IDENTITY]\n[ACTION]: (UPDATE PHOTO)\n[USER]: '..user_id..'\n[PHOTO]: '..image..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```'..image)
            return
        end
    end
    return TriggerClientEvent('notify', source, 'Identidade', 'Não foi possível atualizar a sua <b>identidade</b>.')
end

getUserPhoto = function(user_id)
    local query = zero.query('zero_identity/getUserPhoto', { user_id = user_id })[1]
    if (query) then
        return query.url
    end
    zero.execute('zero_identity/insertPhoto', { user_id = user_id, url = configGeneral._defaultPhoto })
    return configGeneral._defaultPhoto
end

getUserJob = function(user_id)
    local job, jobinfo = zero.getUserGroupByType(user_id, 'fac')
    if (not job) then job, jobinfo = zero.getUserGroupByType(user_id, 'job'); end;
    if (job) then
        return zero.getGroupTitle(job, jobinfo.grade)..((jobinfo.active and ' (ativo)') or '')
    end
    return 'Desempregado'
end

getUserCoins = function(user_id)
    return 0    
end

getUserStaff = function(user_id)
    local staff, staffinfo = zero.getUserGroupByType(user_id, 'staff')
    if (staff) then
        return zero.getGroupTitle(staff, staffinfo.grade)..((staffinfo.active and ' (ativo)') or '')
    end
    return nil
end

getUserVip = function(user_id)
    local staff, staffinfo = zero.getUserGroupByType(user_id, 'vips')
    if (staff) then
        return zero.getGroupTitle(staff, staffinfo.grade)
    end
    return nil
end

getUserRelationship = function(user_id)
    local relation, couple, status = exports.zero_core:CheckUser(user_id)
    return (status or 'Solteiro(a)')
end

getUserDrivelicense = function(user_id)
    return nil
end

getUserGunlicense = function(user_id)
    return nil
end