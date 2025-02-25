local srv = {}
Tunnel.bindInterface('Salary', srv)

local salarys = {
    ----------------------------------
    -- STAFF
    ----------------------------------
    { name = '[Zero] CEO', value = 300000, perm = '@Staff.CEO' },
    { name = '[Zero] COO', value = 25000, perm = '@Staff.COO' },
    { name = '[Zero] Manager', value = 10000, perm = '@Staff.Manager' },
    { name = '[Zero] Adm', value = 5000, perm = '@Staff.Administrador' },
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
    -- Jurídico
    ----------------------------------
    { name = '[Jurídico] Estagiário', value = 500, perm = '@Juridico.Estagiario' },
    { name = '[Jurídico] Segurança', value = 3000, perm = '@Juridico.Seguranca' },
    { name = '[Jurídico] Chefe da Segurança', value = 4000, perm = '@Juridico.ChefeSeguranca' },
    { name = '[Jurídico] Advogado Jr', value = 1000, perm = '@Juridico.AdvogadoJunior' },
    { name = '[Jurídico] Advogado Pleno', value = 1500, perm = '@Juridico.AdvogadoPleno' },
    { name = '[Jurídico] Advogado Senior', value = 2000, perm = '@Juridico.AdvogadoSenior' },
    { name = '[Jurídico] Secretário Adjunto', value = 2500, perm = '@Juridico.SecretarioAdjunto' },
    { name = '[Jurídico] Secretário Geral', value = 3500, perm = '@Juridico.SecretarioGeral' },
    { name = '[Jurídico] Vice-Presidente', value = 4000, perm = '@Juridico.VicePresidente' },
    { name = '[Jurídico] Presidente', value = 6000, perm = '@Juridico.Presidente' },
    ----------------------------------
    -- Policia
    ----------------------------------
    { name = '[Policia] Soldado E.V', value = 3250, perm = '@Policia.SoldadoEV' },
    { name = '[Policia] Soldado E.P', value = 3500, perm = '@Policia.SoldadoEP' },
    { name = '[Policia] Cabo', value = 4000, perm = '@Policia.Cabo' },
    { name = '[Policia] 3° Sargento', value = 4500, perm = '@Policia.Sargento3' },
    { name = '[Policia] 2° Sargento', value = 4600, perm = '@Policia.Sargento2' },
    { name = '[Policia] 1° Sargento', value = 4700, perm = '@Policia.Sargento1' },
    { name = '[Policia] Subtenente', value = 4800, perm = '@Policia.SubTenente' },
    { name = '[Policia] Aspirante a Oficial', value = 5000, perm = '@Policia.Aspirante' },
    { name = '[Policia] 2° Tenente', value = 6000, perm = '@Policia.Tenente2' },
    { name = '[Policia] 1° Tenente', value = 6500, perm = '@Policia.Tenente1' },
    { name = '[Policia] Capitão', value = 7500, perm = '@Policia.Capitao' },
    { name = '[Policia] Major', value = 8500, perm = '@Policia.Major' },
    { name = '[Policia] Tenente-Coronel', value = 10000, perm = '@Policia.TenenteCoronel' },
    { name = '[Policia] Coronel', value = 12000, perm = '@Policia.Coronel' },
    { name = '[Policia] General', value = 15000, perm = '@Policia.General' },
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
    { name = '[CMZ] Paramedico', value = 3500, perm = '@Hospital.Paramedico' },
    { name = '[CMZ] Enfermeiro', value = 5000, perm = '@Hospital.Enfermeiro' },
    { name = '[CMZ] Medico', value = 6000, perm = '@Hospital.Medico' },
    { name = '[CMZ] Cirurgiao', value = 7500, perm = '@Hospital.Cirurgiao' },
    { name = '[CMZ] Vice-Diretor', value = 8500, perm = '@Hospital.ViceDiretor' },
    { name = '[CMZ] Diretora', value = 25000, perm = '@Hospital.Diretor' },
}

giveSalary = function(source, user_id)
    if (source and user_id) then
        for k, v in pairs(salarys) do
            local value = v.value
            if (zero.hasPermission(user_id, v.perm)) then
                if (string.find(v.perm, '@Policia') or string.find(v.perm, '@Deic')) and zero.hasPermission(user_id, 'vippm.permissao') then value = parseInt(value + 5000); end;
                zero.giveBankMoney(user_id, value)
                exports.zero_bank:extrato(user_id, 'Salário ', value)

                TriggerClientEvent('zero_sound:source', source, 'coins', 0.5)
                TriggerClientEvent('notify', source, 'Salário', 'Olá! Seu salário ('..v.name..') de <b>R$'..zero.format(value)..'</b> foi depositado em sua conta bancária.')
            end
        end
    end
end

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(30 * 60 * 1000)
        for user_id, source in pairs(zero.getUsers()) do
            giveSalary(source, user_id)
        end  
    end
end)