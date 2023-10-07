cRewards = {}
Tunnel.bindInterface('zero_rewards', cRewards)
sRewards = Tunnel.getInterface('zero_rewards')

firstHourRegister = true
currentTime = 0
registerTime = 0

cRewards.open = function(data)
    SetNuiFocus(true, true)
    SendNUIMessage(data)
end

RegisterNuiCallback('close', function()
    SetNuiFocus(false, false)
end)

RegisterNuiCallback('openReward', function()
    sRewards.openBox()
end)

Citizen.CreateThread(function()
    while true do
        if not firstHourRegister then 
            currentTime = currentTime + 1
            registerTime = registerTime + 1

            if currentTime == config.creditRegisterTime then
                currentTime = 0
                sRewards.addReward()
                print('Adicionar um crédito de caixa')
            end

            if registerTime == config.registerTime then
                registerTime = 0
                sRewards.registerTime()
                print("Registrar no banco o tempo")
            end
        else
            firstHourRegister = false
        end
        Wait(60000)
    end
end)