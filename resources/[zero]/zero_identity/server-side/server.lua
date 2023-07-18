srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

zero._prepare('zero_identity/getUserPhoto', 'select url from zero_identity where user_id = @user_id')

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

getUserPhoto = function(user_id)
    local query = zero.query('zero_identity/getUserPhoto', { user_id = user_id })[1]
    if (query) then
        return query.url
    end
    return nil
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