local srv = {}
Tunnel.bindInterface('Salary', srv)

local salarys = {
    ----------------------------------
    -- STAFF
    ----------------------------------
    { name = '[Zero] CEO', value = 50000, perm = '@Staff.CEO' },
    { name = '[Zero] COO', value = 25000, perm = '@Staff.COO' },
    { name = '[Zero] Manager', value = 10000, perm = '@Staff.Manager' },
    { name = '[Zero] Adm', value = 10000, perm = '@Staff.Manager' },
    ----------------------------------
    -- VIPS
    ----------------------------------
    { name = '[VIP] Bronze', value = 1000, perm = '@Vips.Bronze' },
    { name = '[VIP] Prata', value = 2000, perm = '@Vips.Prata' },
    { name = '[VIP] Ouro', value = 3000, perm = '@Vips.Ouro' },
    { name = '[VIP] Rubi', value = 4000, perm = '@Vips.Rubi' },
    { name = '[VIP] Ametista', value = 5000, perm = '@Vips.Ametista' },
    { name = '[VIP] Safira', value = 7000, perm = '@Vips.Safira' },
    { name = '[VIP] Diamante', value = 10000, perm = '@Vips.Diamante' },
    { name = '[VIP] Zero', value = 10000, perm = '@Vips.Zero' },
    ----------------------------------
    -- Policia
    ----------------------------------
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
                zero.giveBankMoney(user_id, value)
                exports.zero_bank:extrato(user_id, 'Salário', value)
                TriggerClientEvent('notify', source, 'Salário', 'Olá! Seu salário ('..v.name..') de <b>R$'..zero.format(value)..'</b> foi depositado em sua conta bancária.')
            end
        end
    end
end