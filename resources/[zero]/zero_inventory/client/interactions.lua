verifyNearest = false
pedCache = {}

cInventory.checkNui = function(sendersTable, senderCoords, distance)
    verifyNearest = true

    local ped = PlayerPedId()
    if not (pedCache[ped]) then
        pedCache[ped] = { 
            receiveRequest = sendersTable[1], 
            sendRequest = sendersTable[2] 
        }
    end
    
    while (verifyNearest) do
        local verifyDistance = #(GetEntityCoords(ped) - senderCoords)
        if verifyDistance > distance then
            sInventory.callBackInteractions(sendersTable[1], sendersTable[2])
            verifyNearest = false
            pedCache[ped] = nil
            break
        end
        Citizen.Wait(5)
    end
end