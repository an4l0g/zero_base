getUserFullname = function(user_id)
    local identity = zero.getUserIdentity(user_id)
    if (identity) then
        return identity.firstname..' '..identity.lastname
    end
    return 'Indivíduo Indigente'
end
exports('userFullname', userFullname)

getUserRegistration = function(user_id)
    local identity = zero.getUserIdentity(user_id)
    if (identity) then
        return identity.registration
    end
    return 'AAAABBBB'
end
exports('getUserRegistration', getUserRegistration)

getUserAge = function(user_id)
    local identity = zero.getUserIdentity(user_id)
    if (identity) then
        return identity.age
    end
    return 0
end
exports('getUserAge', getUserAge)

getUserPhone = function(user_id)
    local identity = zero.getUserIdentity(user_id)
    if (identity) then
        return identity.phone
    end
    return '000-000'
end
exports('getUserPhone', getUserPhone)

zero._prepare('zero_identity/getUserRH', 'select rh from zero_creation where user_id = @user_id')
getUserRH = function(user_id)
    local query = zero.query('zero_identity/getUserRH', { user_id = user_id })[1]
    if (query) then
        return query.rh
    end
    return 'Desconhecido'
end
exports('getUserRH', getUserRH)