sRADIO = {}
Tunnel.bindInterface('vrp_radio',sRADIO)

function sRADIO.allowRadios()
	local cb = {}
	local source = source
	local user_id = zero.getUserId(source)
	if user_id then
		for rnum,data in pairs(radios) do
			if (#data.permissions > 1) then
				local allow = 0
				for i,p in pairs(data.permissions) do
					if zero.hasPermission(user_id,p) then
						allow = allow + 1
					end
				end
				if (allow > 0) then
					table.insert(cb,{ name = data.name, radio = rnum })
				end
			else
				if zero.hasPermission(user_id,data.permissions[1]) then
					table.insert(cb,{ name = data.name, radio = rnum })
				end
			end
		end
	end
	return cb
end

function sRADIO.allowConnect(rnum)
	local source = source
	if rnum > 0 then
		local user_id = zero.getUserId(source)
		
		local data = radios[rnum]
		if (#data.permissions > 1) then
			local allow = 0
			for i,p in pairs(data.permissions) do
				if zero.hasPermission(user_id,p) then
					allow = allow + 1
				end
			end
			if (allow > 0) then
				TriggerClientEvent('notify',source,'Rádio','Entrando no Canal: <b>'..data.name..'</b>.',8000)
				return true
			end
		else
			if zero.hasPermission(user_id,data.permissions[1]) then
				TriggerClientEvent('notify',source,'Rádio','Entrando no Canal: <b>'..data.name..'</b>.',8000)
				return true
			end
		end
		
		TriggerClientEvent('notify',source,'Rádio','Você não tem permissão.',8000)
	end
	return false
end

function sRADIO.checkRadio(msg)
	local source = source
	local user_id = zero.getUserId(source)
	if zero.getInventoryItemAmount(user_id,'radio') >= 1 then
		return true
	else
		if msg then
			TriggerClientEvent('notify',source,'Rádio','Você precisa comprar o <b>Rádio</b> em uma <b>Loja de Departamento</b>.',8000)
		end
		return false
	end
end

function sRADIO.getFreqName(rnum)
	return radios[rnum].name
end

function GetRandomPhoneticLetter()
	local phoneticAlphabet = {
		'Alpha','Bravo','Charlie','Delta','Echo','Foxtrot','Golf','Hotel','India','Juliet','Kilo','Lima','Mike','November',
		'Oscar','Papa','Quebec','Romeo','Sierra','Tango','Uniform','Victor','Whisky','XRay','Yankee','Zulu',
	}
	math.randomseed(GetGameTimer())
	return phoneticAlphabet[math.random(1, #phoneticAlphabet)]
end
local phonetic = {}
function sRADIO.setPlayerName(f)
	local source = source
	local user_id = zero.getUserId(source)
	if user_id then
		local name = nil
		if (f >= 2) and (f <= 6) then
			if (not phonetic[source]) then
				if zero.hasPermission(user_id, 'policiacivil.permissao') then
					phonetic[source] = GetRandomPhoneticLetter()..' - '..source    
				else
					phonetic[source] = GetRandomPhoneticLetter()..' - '..user_id    
				end
			end
			name = phonetic[source]
		else
			local identity = zero.getUserIdentity(user_id)
			name = identity.name..' '..identity.firstname..' | '..user_id
		end   
		if (GetResourceState('pma-listners') == 'started') then
			exports['pma-listners']:setListName(source,name)
		end
	end
end
AddEventHandler('vRP:playerLeave',function(user_id,source)
	phonetic[source] = nil
end)

-- TriggerClientEvent('radio:outServers',_source) Evento pra tirar do radio