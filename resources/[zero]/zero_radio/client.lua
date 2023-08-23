sRADIO = Tunnel.getInterface('vrp_radio')

function outServers()
	exports['pma-voice']:removePlayerFromRadio()
	exports['pma-voice']:setVoiceProperty('radioEnabled',false)
	TriggerEvent('pma-listners:setFrequency',0)
end

exports('outServers',outServers)
RegisterNetEvent('radio:outServers',outServers)
AddEventHandler('vRP:onPlayerDied',outServers)

RegisterNUICallback('ButtonClick',function(data,cb)
	local btn, radio = table.unpack(splitString(data,'-'))	
	if (btn == 'connect') and radio then	
		local radioFreq = parseInt(radio)
		if sRADIO.allowConnect(radioFreq) then
			outServers()
			sRADIO.setPlayerName(radioFreq)
			exports['pma-voice']:setRadioChannel(radioFreq)
			exports['pma-voice']:setVoiceProperty('radioEnabled',true)
			TriggerEvent('pma-listners:setFrequency',sRADIO.getFreqName(radioFreq))
		end		
	elseif (btn == 'disconnect') then	
		outServers()
		TriggerEvent('Notify','sucesso','Desconectou de todos os canais.')
	elseif (data == 'close') then
		SetNuiFocus(false,false)
		SendNUIMessage({ showmenu = false })
	end
end)

RegisterCommand('radio',function(source,args,rawCmd)
    if sRADIO.checkRadio(true) then
		local radios = sRADIO.allowRadios()
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true, radios = radios  })
	end
end)

RegisterCommand('radiof',function(source,args)
	if args[1] then
		local radioFreq = parseInt(args[1])
		if radioFreq > 80 and radioFreq <= 1000 then
        	if sRADIO.checkRadio(true) then
				outServers()
				sRADIO.setPlayerName(radioFreq)
				exports['pma-voice']:setRadioChannel(radioFreq)
				exports['pma-voice']:setVoiceProperty('radioEnabled',true)
				TriggerEvent('Notify','sucesso','Você entrou na Frequência <b>'..radioFreq..'</b> do rádio.',8000)
				TriggerEvent('pma-listners:setFrequency',radioFreq)
			end
		else
			TriggerEvent('Notify','negado','Você não tem permissão.')
		end
    end
end)

RegisterCommand('radiod',function(source,args)
    if sRADIO.checkRadio(true) then
		outServers()
		TriggerEvent('Notify','sucesso','Você desconectou de todos os canais.')
	end
end)