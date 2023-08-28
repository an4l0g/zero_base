local vSERVER = Tunnel.getInterface('Salary')

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait(30 * 60 * 1000)
        vSERVER.giveSalary()
    end
end)