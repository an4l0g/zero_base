Cirurgia = function(source)
    vCLIENT.createCharacter(source)
end
exports('Cirurgia', Cirurgia)

RegisterCommand('cirurgia', function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, '+Hospital.Medico') then
        local nUser = exports.zero_hud:prompt(source, {
            'Passaporte do Paciente'
        })

        if (nUser) then
            nUser = parseInt(nUser[1])
            local nIdentity = zero.getUserIdentity(nUser)

            local nSource = zero.getUserSource(nUser)
            if (nSource) then
                local request = exports.zero_hud:request(source, 'Você deseja prosseguir com a cirurgia do paciente '..nIdentity.firstname..' '..nIdentity.lastname..'?', 30000)
                if (request) then
                    exports[GetCurrentResourceName()]:Cirurgia(nSource)
                    TriggerClientEvent('notify', source, 'Cirurgia', 'A cirurgia do seu <b>paciente</b> foi um sucesso!')
                    exports.zero:webhook('Cirurgia', '```prolog\n[ZERO HOSPITAL]\n[ACTION]: (CIRURGIA)\n[USER]: '..user_id..'\n[TARGET]: '..nUser..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                end
            else
                TriggerClientEvent('notify', source, 'Cirurgia', 'O mesmo se encontra <b>offline</b>!')
            end
        end
    end
end)

RegisterNetEvent('zero_interactions:cirurgia', function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, '+Hospital.Medico') then
        local nUser = exports.zero_hud:prompt(source, {
            'Passaporte do Paciente'
        })

        if (nUser) then
            nUser = parseInt(nUser[1])
            local nIdentity = zero.getUserIdentity(nUser)

            local nSource = zero.getUserSource(nUser)
            if (nSource) then
                local request = exports.zero_hud:request(source, 'Você deseja prosseguir com a cirurgia do paciente '..nIdentity.firstname..' '..nIdentity.lastname..'?', 30000)
                if (request) then
                    exports[GetCurrentResourceName()]:Cirurgia(nSource)
                    TriggerClientEvent('notify', source, 'Cirurgia', 'A cirurgia do seu <b>paciente</b> foi um sucesso!')
                    exports.zero:webhook('Cirurgia', '```prolog\n[ZERO HOSPITAL]\n[ACTION]: (CIRURGIA)\n[USER]: '..user_id..'\n[TARGET]: '..nUser..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..' \r```')
                end
            else
                TriggerClientEvent('notify', source, 'Cirurgia', 'O mesmo se encontra <b>offline</b>!')
            end
        end
    end
end)