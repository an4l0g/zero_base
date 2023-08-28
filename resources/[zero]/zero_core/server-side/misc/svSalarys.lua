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
    { name = '[VIP] Bronze', value = 500, perm = '@Vips.Bronze' },
    { name = '[VIP] Prata', value = 1000, perm = '@Vips.Prata' },
    { name = '[VIP] Ouro', value = 1500, perm = '@Vips.Ouro' },
    { name = '[VIP] Rubi', value = 2000, perm = '@Vips.Rubi' },
    { name = '[VIP] Ametista', value = 2500, perm = '@Vips.Ametista' },
    { name = '[VIP] Safira', value = 3500, perm = '@Vips.Safira' },
    { name = '[VIP] Diamante', value = 5000, perm = '@Vips.Diamante' },
    { name = '[VIP] Zero', value = 7500, perm = '@Vips.Zero' },
    ----------------------------------
    -- Policia
    ----------------------------------
    { name = '[Policia] Soldado', value = 3250, perm = '@Policia.Soldado' },
    { name = '[Policia] Graduado', value = 5000, perm = '@Policia.Graduado' },
    { name = '[Policia] Oficial', value = 6250, perm = '@Policia.Oficial' },
    { name = '[Policia] A. Escalão', value = 7500, perm = '@Policia.AltoEscalao' },
    { name = '[Policia] S. CMD', value = 8750, perm = '@Policia.SubComandante' },
    { name = '[Policia] CMD', value = 10000, perm = '@Policia.Comandante' },
    ----------------------------------
    -- DEIC
    ----------------------------------
    { name = '[DEIC] Acadepol', value = 3250, perm = '@Deic.Acadepol' },
    { name = '[DEIC] Agente', value = 4000, perm = '@Deic.Agente' },
    { name = '[DEIC] Perito', value = 4250, perm = '@Deic.Perito' },
    { name = '[DEIC] Especialista', value = 4500, perm = '@Deic.Especialista' },
    { name = '[DEIC] Inspetor', value = 4250, perm = '@Deic.Inspetor' },
    { name = '[DEIC] Intendente', value = 5000, perm = '@Deic.Intendente' },
    { name = '[DEIC] Superintendente', value = 6000, perm = '@Deic.Superintendente' },
    { name = '[DEIC] Comissario', value = 7000, perm = '@Deic.Comissario' },
    { name = '[DEIC] Delegado', value = 7500, perm = '@Deic.Delegado' },
    { name = '[DEIC] Diretor', value = 8750, perm = '@Deic.Diretor' },
    ----------------------------------
    -- Hospital
    ----------------------------------
    { name = '[CMZ] Paramedico', value = 7000, perm = '@Hospital.Paramedico' },
    { name = '[CMZ] Enfermeiro', value = 10000, perm = '@Hospital.Enfermeiro' },
    { name = '[CMZ] Medico', value = 12000, perm = '@Hospital.Medico' },
    { name = '[CMZ] Cirurgiao', value = 15000, perm = '@Hospital.Cirurgiao' },
    { name = '[CMZ] Vice-Diretor', value = 17000, perm = '@Hospital.ViceDiretor' },
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