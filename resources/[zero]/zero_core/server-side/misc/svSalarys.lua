local srv = {}
Tunnel.bindInterface('Salary', srv)

local salarys = {
    { name = 'Staff. Dono', value = 50000, perm = '@Dono.Dono' }
}

srv.giveSalary = function()
    local source = source
    zero.antiflood(source, 'give:salary', 2)
    local user_id = zero.getUserId(source)
    if (user_id) then
        for k, v in pairs(salarys) do
            local value = v.value
            if (zero.hasPermission(user_id, v.perm)) then
                TriggerClientEvent('zero_sound:source', source, 'coins', 0.5)
                -- exports['gb_bank']:register_trans(user_id,"Salário: "..v.nome, payment)
                zero.giveBankMoney(user_id, value)
                TriggerClientEvent('notify', source, 'Salário', 'Olá! Seu salário ('..v.name..') de <b>R$'..zero.format(value)..'</b> foi depositado em sua conta bancária.')
            end
        end
    end
end