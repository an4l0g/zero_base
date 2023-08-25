local srv = {}
Tunnel.bindInterface('Salary', srv)

local salarys = {
    ----------------------------------
    -- STAFF
    ----------------------------------
    { name = '[Zero] CEO', value = 300000, perm = '@Staff.CEO' },
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
    { name = '[Policia] Soldado', value = 7500, perm = '@Policia.Soldado' },
    { name = '[Policia] Graduado', value = 10000, perm = '@Policia.Graduado' },
    { name = '[Policia] Oficial', value = 12500, perm = '@Policia.Oficial' },
    { name = '[Policia] A. Escalão', value = 15000, perm = '@Policia.AltoEscalao' },
    { name = '[Policia] S. CMD', value = 17500, perm = '@Policia.SubComandante' },
    { name = '[Policia] CMD', value = 20000, perm = '@Policia.Comandante' },
    ----------------------------------
    -- DEIC
    ----------------------------------
    { name = '[DEIC] Acadepol', value = 7500, perm = '@Deic.Acadepol' },
    { name = '[DEIC] Agente', value = 8000, perm = '@Deic.Agente' },
    { name = '[DEIC] Perito', value = 8500, perm = '@Deic.Perito' },
    { name = '[DEIC] Especialista', value = 9000, perm = '@Deic.Especialista' },
    { name = '[DEIC] Inspetor', value = 9500, perm = '@Deic.Inspetor' },
    { name = '[DEIC] Intendente', value = 10000, perm = '@Deic.Intendente' },
    { name = '[DEIC] Superintendente', value = 12000, perm = '@Deic.Superintendente' },
    { name = '[DEIC] Comissario', value = 14000, perm = '@Deic.Comissario' },
    { name = '[DEIC] Delegado', value = 15000, perm = '@Deic.Delegado' },
    { name = '[DEIC] Diretor', value = 17500, perm = '@Deic.Diretor' },
    ----------------------------------
    -- Hospital
    ----------------------------------
    { name = '[CMZ] Paramedico', value = 10000, perm = '@Hospital.Paramedico' },
    { name = '[CMZ] Enfermeiro', value = 14000, perm = '@Hospital.Enfermeiro' },
    { name = '[CMZ] Medico', value = 16000, perm = '@Hospital.Medico' },
    { name = '[CMZ] Cirurgiao', value = 18000, perm = '@Hospital.Cirurgiao' },
    { name = '[CMZ] Vice-Diretor', value = 20000, perm = '@Hospital.ViceDiretor' },
    { name = '[CMZ] Diretora', value = 50000, perm = '@Hospital.Diretor' },
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