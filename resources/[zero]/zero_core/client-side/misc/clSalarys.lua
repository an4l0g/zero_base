local vSERVER = Tunnel.getInterface('Salary')

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(60 * 60 * 1000)
        vSERVER.giveSalary()
    end
end)