local srv = {}
Tunnel.bindInterface('Macas', srv)
local vCLIENT = Tunnel.getInterface('Macas')

srv.startTratamento = function(index)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local permissions = zero.getUsersByPermission('hospital.permissao')
        if (#permissions >= 1) then
            TriggerClientEvent('notify', source, 'Hospital', 'Você não pode utilizar o <b>auto tratamento</b> com paramédicos em serviço!')
            return false
        end
    end
    vCLIENT.setTratamento(source, index)
    return true
end

local tratamentoValue = 1000

RegisterCommand('tratamento', function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'hospital.permissao') then
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            if (GetEntityHealth(GetPlayerPed(nPlayer)) >= 200) then  TriggerClientEvent('notify', source, 'Hospital', 'O <b>paciente</b> está com a vida cheia!') return; end;
            local nUser = zero.getUserId(nPlayer)
            if (vCLIENT.checkMaca(nPlayer)) then
                local request = exports.zero_hud:request(nPlayer, 'Você deseja pagar R$'..zero.format(tratamentoValue)..' no tratamento?', 30000)
                if (request) then
                    if (zero.tryFullPayment(nUser, tratamentoValue)) then
                        TriggerClientEvent('notify', source, 'Hospital', 'Você iniciou o tratamento no <b>paciente</b>!')
                        zero.giveBankMoney(user_id, tratamentoValue)
                        vCLIENT.setTratamento(nPlayer)
                    else
                        TriggerClientEvent('notify', source, 'Hospital', 'O paciente não possui <b>R$'..zero.format(tratamentoValue)..'</b> para pagar o tratamento!')
                        TriggerClientEvent('notify', nPlayer, 'Hospital', 'Você não possui <b>R$'..zero.format(tratamentoValue)..'</b> para pagar o tratamento!')
                    end
                else
                    TriggerClientEvent('notify', source, 'Hospital', 'O paciente não aceitou pagar o <b>tratamento</b>!')
                end
            else
                TriggerClientEvent('notify', source, 'Hospital', 'O paciente não se encontra <b>deitado</b> na maca!')
            end
        end
    end
end)

RegisterNetEvent('zero_interactions:tratamento', function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, 'hospital.permissao') then
        local nPlayer = zeroClient.getNearestPlayer(source, 2.0)
        if (nPlayer) then
            if (GetEntityHealth(GetPlayerPed(nPlayer)) >= 200) then  TriggerClientEvent('notify', source, 'Hospital', 'O <b>paciente</b> está com a vida cheia!') return; end;
            local nUser = zero.getUserId(nPlayer)
            if (vCLIENT.checkMaca(nPlayer)) then
                local request = exports.zero_hud:request(nPlayer, 'Você deseja pagar R$'..zero.format(tratamentoValue)..' no tratamento?', 30000)
                if (request) then
                    if (zero.tryFullPayment(nUser, tratamentoValue)) then
                        TriggerClientEvent('notify', source, 'Hospital', 'Você iniciou o tratamento no <b>paciente</b>!')
                        zero.giveBankMoney(user_id, tratamentoValue)
                        vCLIENT.setTratamento(nPlayer)
                    else
                        TriggerClientEvent('notify', source, 'Hospital', 'O paciente não possui <b>R$'..zero.format(tratamentoValue)..'</b> para pagar o tratamento!')
                        TriggerClientEvent('notify', nPlayer, 'Hospital', 'Você não possui <b>R$'..zero.format(tratamentoValue)..'</b> para pagar o tratamento!')
                    end
                else
                    TriggerClientEvent('notify', source, 'Hospital', 'O paciente não aceitou pagar o <b>tratamento</b>!')
                end
            else
                TriggerClientEvent('notify', source, 'Hospital', 'O paciente não se encontra <b>deitado</b> na maca!')
            end
        end
    end
end)

local saveMaca = {}
local tempIndex = {}

srv.verifyMaca = function(index)
    if (saveMaca[index]) then
        return true
    end
    return false
end

srv.saveMaca = function(index)
    local source = source
    tempIndex[zero.getUserId(source)] = index
    saveMaca[index] = true
end

srv.deleteMaca = function()
    local source = source
    local user_id = zero.getUserId(source)
    saveMaca[tempIndex[user_id]] = nil
    tempIndex[user_id] = nil
end

AddEventHandler('zero:playerLeave', function(user_id, source)
	local source = source
	if (saveMaca[tempIndex[user_id]]) then
		saveMaca[tempIndex[user_id]] = nil
        tempIndex[user_id] = nil
	end
end)