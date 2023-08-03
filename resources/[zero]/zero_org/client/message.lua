RegisterNUICallback('sendMessage', function(data, cb)
    SetNuiFocus(false, false)
    cb(json.encode(gbMessage.sendMessageToFac(data.fac, 'aviso', data.message)))
end)
