srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

local configGeneral = config.general

zero._prepare('zero_identity/getUserPhoto', 'select url from zero_identity where user_id = @user_id')
zero._prepare('zero_identity/insertPhoto', 'insert into zero_identity (user_id, url) values (@user_id, @url)')
zero._prepare('zero_identity/updatePhoto', 'update zero_identity set url = @url where user_id = @user_id')

srv.getUserIdentity = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
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

srv.getUserRegistration = function(args)
    local source = source

    local nearestPlayer = zero.getNearestPlayer(source, 2.0)
    local nUser
    if (nearestPlayer) then
        nUser = zero.getUserId(nearestPlayer)
    else
        
    end

    if (nearestPlayer) then
         
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
                return table
            else
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
                return table
            end
        end
    end
end

RegisterCommand('rg', function(source, args)
    local user_id = zero.getUserId(source)
    if (user_id and zero.checkPermissions(configGeneral.perms)) then
        if (args[1] and zero.hasPermission(configGeneral.staffPermission)) then
            
        else
            
        end
    end
end)

srv.updatePhoto = function(image)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        zero.execute('zero_identity/updatePhoto', { user_id = user_id, url = image })
        return
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
        return zero.getGroupTitle(zero, jobinfo.grade)..((jobinfo.active and ' (ativo)') or '')
    end
    return 'Desempregado'
end

getUserCoins = function(user_id)
    return 0    
end

getUserStaff = function(user_id)
    local staff, staffinfo = zero.getUserGroupByType(user_id, 'staff')
    if (staff) then
        return zero.getGroupTitle(zero, staffinfo.grade)..((staffinfo.active and ' (ativo)') or '')
    end
    return nil
end

getUserVip = function(user_id)
    return nil
end

getUserRelationship = function(user_id)
    return nil
end

getUserDrivelicense = function(user_id)
    return nil
end

getUserGunlicense = function(user_id)
    return nil
end