local generalConfig = config.general

srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)

vRP._prepare('zero_homes/getHomeOwner', 'select * from zero_homes where home = @home AND home_owner = 1')
vRP._prepare('zero_homes/buyHome', 'UPDATE vrp_user_identities SET phone = @phone WHERE user_id = @user_id')

local verifyTax = function(taxTime)
    if (taxTime >= 0) then
        if (os.time() >= parseInt((taxTime + generalConfig.lateFee) * 24 * 60 * 60))
    end
    return true
end

srv.tryEnterHome = function(home)
    local _source = source
    local _userId = vRP.getUserId(_source)
    if (_userId and home) then
        local consultHome = vRP.query('zero_homes/getHomeOwner', { home = home })[1]
        if (consultHome) then
            -- [ Verificar taxa da casa ] --
            local taxTime = parseInt(consultHome.tax)
            verifyTax(taxTime)

        else
            print('Propriedade à venda!')
        end
    end
end