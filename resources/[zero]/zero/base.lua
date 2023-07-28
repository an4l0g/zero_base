local config = module('zero', 'cfg/general')

Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
Tools = module('zero', 'lib/Tools')

zero = {}
Proxy.addInterface('zero', zero)
Tunnel.bindInterface('zero', zero)
exportTable(zero)

zeroClient = Tunnel.getInterface("zero")

zero.webhook = function(link, message)
	if (link and message and link ~= '') then
		PerformHttpRequest(link, function(err, text, headers) end, 'POST', json.encode({ content = message }), { ['Content-Type'] = 'application/json' })
	end
end

zero.formatWebhook = function(url, title, body)
    local currentBody = '```prolog\n['..string.upper(title)..']\n'
    for k,v in ipairs(body) do
        currentBody = currentBody..'\n['..string.upper(v[1])..']: '..string.upper(v[2])
    end
    currentBody = currentBody..os.date('\n\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'```'
    zero.webhook(url, currentBody)
end

cacheUsers = {}
cacheUsers.users = {}
cacheUsers.rusers = {}
cacheUsers.user_source = {}

local db_drivers = {}
local db_driver
local cached_prepares = {}
local cached_queries = {}
local prepared_queries = {}
local db_initialized = false

zero.registerDBDriver = function(name, on_init, on_prepare, on_query)
	if not db_drivers[name] then
		db_drivers[name] = { on_init, on_prepare, on_query }
		if name == 'oxmysql' then
			db_driver = db_drivers[name]
			local ok = on_init('oxmysql')
			if ok then
				db_initialized = true
				for _,prepare in pairs(cached_prepares) do
					on_prepare(table.unpack(prepare,1,table.maxn(prepare)))
				end
				for _,query in pairs(cached_queries) do
					query[2](on_query(table.unpack(query[1],1,table.maxn(query[1]))))
				end
				cached_prepares = nil
				cached_queries = nil
			end
		end
	end
end

zero.prepare = function(name, query)
	prepared_queries[name] = true
	if db_initialized then
		db_driver[2](name,query)
	else
		table.insert(cached_prepares,{ name,query })
	end
end

zero.query = function(name, params, mode)
	if not mode then mode = "query" end
	if db_initialized then
		return db_driver[3](name,params or {},mode)
	else
		local r = async()
		table.insert(cached_queries,{{ name,params or {},mode },r })
		return r:wait()
	end
end

zero.execute = function(name, params)
	return zero.query(name, params, "execute")
end

zero.insert = function(name, params)
	return zero.query(name, params, "insert")
end

zero.scalar = function(name, params)
	return zero.query(name, params, "scalar")
end

zero.format = function(n)
	local left, num, right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

zero.isBanned = function(user_id)
	return exports['zero_core']:isBanned(user_id)
end

zero.setBanned = function(user_id, banned)
	return exports['zero_core']:setBanned(user_id, banned)
end

zero.getIdentifiers = function(source)
    local identifiers = {}
    for i = 0, GetNumPlayerIdentifiers(source)-1 do
        local id = GetPlayerIdentifier(source, i)
        
		local prefix = splitString(id,":")[1]
		identifiers[prefix] = id
    end
    return identifiers
end

zero.getUData = function(user_id, key)
	local rows = zero.query("vRP/get_userdata", { user_id = user_id, key = key })
	if #rows > 0 then
		return rows[1].dvalue
	end
	return ""
end

zero.setUData = function(user_id, key, value)
	zero.execute("vRP/set_userdata", { user_id = user_id, key = key, value = value })
end

zero.getSData = function(key)
	local rows = zero.query("vRP/get_srvdata", { key = key })
	if #rows > 0 then
		return rows[1].dvalue
	end
	return ""
end

zero.setSData = function(key, value)
	zero.execute("vRP/set_srvdata",{ key = key, value = value })
end

zero.remSData = function(dkey)
	zero.execute("vRP/rem_srv_data",{ dkey = dkey })
end

zero.getUsers = function()
	local users = {}
	for k, v in pairs(cacheUsers.user_source) do
		users[k] = v
	end
	return users
end

zero.getUserDataTable = function(user_id)
	local uData = zero.getUData(user_id, 'vRP:datatable')
	if (uData) then
		local data = json.decode(uData)
		return data
	end
	return {}
end

zero.getUserId = function(source)
	if (source ~= nil) then
		local ids = GetPlayerIdentifiers(source)
		if ids ~= nil and #ids > 0 then
			return cacheUsers.users[ids[1]]
		end
	end
	print('^2[WARNING]^7 Não foi possivel encontrar o user_id do source ^2'..source..'^7.')
	return nil
end

zero.getUserSource = function(user_id)
	return cacheUsers.user_source[user_id]
end

concatInv = function(TableInv)
	local txt = ''
	if TableInv and type(TableInv) == 'table' then
		for k, v in pairs(TableInv) do
			if k ~= nil and v ~= nil then
				txt = '\n   ' .. zero.format(v.amount or 0) .. 'x ' .. (zero.itemNameList(v.item) or v.item) .. txt
			end
		end
		if txt == '' then
			return 'MOCHILA VAZIA'
		else 
			return txt
		end
	end
	return 'ERRO AO ENCONTRAR INVENTARIO'
end

concatArmas = function(TableInv)
	local txt = ''
	if TableInv and type(TableInv) == 'table' then
		for k, v in pairs(TableInv) do
			txt = '\n   ' .. (zero.itemNameList('wbody|'..k) or k) .. ' [' .. tostring(v.ammo) .. ']' .. txt
		end
		if txt == '' then
			return 'DESARMADO'
		else
			return txt
		end
	end
	return 'ERRO AO ENCONTRAR ARMAS'
end

zero.kick = function(source, reason)
	DropPlayer(source, reason)
end

zero.dropPlayer = function(source, reason)
	if (source) then
		local user_id = zero.getUserId(source)
		local userTable = zero.getUserDataTable(user_id)

		local sPed = GetPlayerPed(source)
		if (not DoesEntityExist(sPed)) then return; end;

		if (user_id) then
			local health, items, weapons = GetEntityHealth(sPed), concatInv(userTable['inventory']), concatArmas(userTable['weapons'])	
			local identifiers = zero.getIdentifiers(source)
			local steamId, steamUrl, discordId = '\n**STEAM HEX:** '..(identifiers['steam'] or 'Offline'), '', ''

			TriggerEvent('vRP:playerLeave', user_id, source)
			TriggerClientEvent('vRP:playerExit', -1, user_id, reason, playerCoords)
			
			if (identifiers['steam']) then steamUrl = '\n**STEAM URL:** https://steamcommunity.com/profiles/'..tonumber(identifiers['steam']:gsub('steam:', ''), 16) end
			if (identifiers['discord']) then discordId = '\n**DISCORD:** <@'..identifiers['discord']:gsub('discord:', '')..'>' end
			zero.webhook(config['webhooks']['exit'], '```prolog\n[LOG]: SAIU\n[SOURCE]: '..source..' [USER_ID]: '..user_id..'\n[IP]: '..(GetPlayerEndpoint(source) or 'NÃO IDENTIFICADO')..'\n[LICENSA UTILIZADA]: '..(GetPlayerIdentifier(source) or 'NÃO IDENTIFICADO')..'\n\n[INFORMAÇÕES DETALHADAS]\n[MOTIVO DA SAÍDA]: '..(reason or 'NÃO IDENTIFICADO')..'\n[INVENTÁRIO]: '..items..'\n[ARMAS EQUIPADAS]: '..weapons..'\n[VIDA]: '..tostring(health)..'\n[COORDS]: '..tostring(GetEntityCoords(sPed))..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'```'..steamId..steamUrl..discordId)		
				
			local save = json.encode(userTable)
			if (save ~= 'null') then zero.setUData(user_id, 'vRP:datatable', save) end

			cacheUsers['users'][cacheUsers['rusers'][user_id]] = nil
			cacheUsers['rusers'][user_id] = nil
			cacheUsers['user_tables'][user_id] = nil
			cacheUsers['user_tmp_tables'][user_id] = nil
			cacheUsers['user_sources'][user_id] = nil
		end
	end
end

-- task_save_datatables = function()
-- 	SetTimeout(30000, task_save_datatables); 
-- 	for k, v in pairs(cacheUsers['user_tables']) do
-- 		zero.setUData(k, 'vRP:datatable', json.encode(v))
-- 	end
-- 	-- print('^2[DataTable]:^7 o banco de dados foi salvo com sucesso.')
-- end

-- async(function()
-- 	task_save_datatables()
-- end)

local createIdentifiers = function(ids)
	local newUserId = zero.insert('zero_framework/createUser')
	if (newUserId > 0) then
		for i = 1, #ids do
			local _ids = ids[i]
			if (string.find(_ids, 'ip:') == nil) then
				zero.execute('zero_framework/addIdentifier', { user_id = newUserId, identifier = _ids })
			end
		end
		return newUserId
	end
	return false
end

zero.getUserIdByIdentifiers = function(ids)
	if (#ids) then
		for i = 1, #ids do
			local _ids = ids[i]
			if (string.find(_ids, 'ip:') == nil) then
				local rows = zero.query('zero_framework/getIdentifier', { identifier = _ids })
				if (#rows > 0) then return rows[1].user_id; end;
			end
		end
	end
	return false
end

formatIdentifiers = function(source)
	local _identifiers = zero.getIdentifiers(source)
	
	local steamURL, steamID = '', ''
	steamID = '\n**[STEAM HEX]** - '..(_identifiers.steam or 'OFFLINE')
	if (_identifiers.steam) then
		steamURL = '\n**[STEAM URL]** - https://steamcommunity.com/profiles/'..tonumber(_identifiers.steam:gsub('steam:', ''), 16)
	end

	local discord;
	discord = '\n**[DISCORD]** - NÃO ENCONTRADO'
	if (_identifiers.discord) then
		discord = '\n**[DISCORD]** - <@'.._identifiers.discord:gsub('discord:', '')..'>'
	end
	return steamURL, steamID, discord
end

AddEventHandler('queue:playerConnecting', function(source, ids, name, _, deferrals)
	local source = source
	if not (name) then name = 'user'; end;

	deferrals.defer()
	deferrals.update('Olá '..name..', estamos carregando as identidades do servidor...')

	if (not ids) then
		deferrals.done('Olá '..name..', ocorreu um problema de identidade, tente logar novamente.')
		TriggerEvent('queue:playerConnectingRemoveQueues', ids)
		return 
	end
		
	local user_id = zero.getUserIdByIdentifiers(ids)
	if (not user_id) then
		local create = createIdentifiers(ids)
		if (not create) then
			deferrals.done('Olá '..name..', ocorreu um problema de identificação, tente logar novamente.')
			TriggerEvent('queue:playerConnectingRemoveQueues', ids)
			return
		end
	end

	if (cacheUsers.user_source[user_id] ~= nil) then
		if (GetPlayerName(cacheUsers.user_source[user_id]) ~= nil) then
			deferrals.done('Olá '..name..', verificamos que o seu passaporte se encontra com problemas, tente logar novamente.')
			TriggerEvent('queue:playerConnectingRemoveQueues', ids)
			DropPlayer(cacheUsers.user_source[user_id], '[ZERO]: Você foi kikado, tente logar novamente!')
			return
		end
	end
		
	deferrals.update('Olá '..name..', estamos carregando os banimentos do servidor...')
	if (zero.isBanned(user_id)) then
		deferrals.done("Você foi banido da cidade. Seu ID é "..user_id)
		TriggerEvent("queue:playerConnectingRemoveQueues",ids)
		return
	end

	if (cacheUsers.rusers[user_id] == nil) then
		cacheUsers.users[ids[1]] = user_id
		cacheUsers.rusers[user_id] = ids[1]
		cacheUsers.user_source[user_id] = source

		TriggerEvent('zero:playerJoin', source, user_id)

		local steamURL, steamID, discord = formatIdentifiers(source)
		zero.webhook(config.webhooks.join, '```prolog\n[ZERO FRAMEWORK]\n[ACTION] (JOIN)\n[USER]: '..user_id..'\n[IP]: '..(GetPlayerEndpoint(source) or '0.0.0.0')..'\n[IDENTIFIERS]: '..json.encode(GetPlayerIdentifiers(source), { indent = true })..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\r```'..steamURL..steamID..discord)
		zero.execute('zero_framework/setLogin', { user_id = user_id, ip = (GetPlayerEndpoint(source) or '0.0.0.0') })
	else
		TriggerEvent('zero:playerRejoin', source, user_id)
	end
	deferrals.done()	
end)

RegisterNetEvent('vRPcli:playerSpawned', function()
	local source = source
	local user_id = zero.getUserId(source)
	if user_id then
		-- cacheUsers['user_sources'][user_id] = source
		
		-- local tmp = zero.getUserTmpTable(user_id)
		-- if tmp then
		-- 	tmp.spawns = tmp.spawns+1
		-- 	first_spawn = (tmp.spawns == 1)
		-- end
		
		-- if first_spawn then
		-- 	Tunnel.setDestDelay(source, 0)
		-- end

		-- TriggerEvent("vRP:playerSpawn",user_id,source,first_spawn)
		-- Player(source).state["vRP:user_id"] = user_id
	else
		zero.webhook(webhookdisc,"```prolog\n[BUG]: Invalid Source\n[SOURCE]: "..tostring(source).."\n[IDS]: "..json.encode(GetPlayerIdentifiers(source)).."```")	
	end
end)

zero.prompt = function(source, questions)
	return exports['zero_hud']:prompt(source, questions)
end

zero.request = function(source, title, time)
	return exports['zero_hud']:request(source, title, time)
end

zero.getDayHours = function(seconds)
    local days = math.floor(seconds/86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds/3600)
    if (days > 0) then
        return string.format('<b>%d Dias</b> e <b>%d Horas</b>', days, hours)
    else
        return string.format('<b>%d Horas</b>', hours)
    end
end

zero.getMinSecs = function(seconds)
    local days = math.floor(seconds/86400)
    seconds = seconds - days * 86400
    local hours = math.floor(seconds/3600)
    seconds = seconds - hours * 3600
    local minutes = math.floor(seconds/60)
    seconds = seconds - minutes * 60

    if (minutes > 0) then
        return string.format('<b>%d Minutos</b> e <b>%d Segundos</b>', minutes, seconds)
    else
        return string.format('<b>%d Segundos</b>', seconds)
    end
end

local delayflood = {}
local flood = {}

zero.antiflood = function(source, key, limite)
	if(flood[key]==nil or delayflood[key] == nil)then 
		flood[key]={}
		delayflood[key]={}
	end
    if(flood[key][source]==nil)then
        flood[key][source] = 1
        delayflood[key][source] = os.time()
    else
        if(os.time()-delayflood[key][source]<1)then
            flood[key][source]= flood[key][source] + 1
            if(flood[key][source]==limite)then
                local user_id = zero.getUserId(source)
				exports['zero_core']:setBanned(user_id, true)
                -- zero.setBanned(user_id,true)
                -- exports["gb_core"]:insertBanRecord(user_id,true,-1,"[ANTI-FLOOD] "..tostring(key))

                DropPlayer(source, "Hoje não! Hoje não! Hoje sim!")
				zero.webhook(config.webhooks.antiflood, "```prolog\n[ID]: "..user_id.." \n[ANTI-FLOOD]: "..key.."\n"..os.date("\n\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```" )
            end
        else
            flood[key][source]=nil
            delayflood[key][source] = nil
        end
        delayflood[key][source] = os.time()
    end
end

-- local webhookCrash = 'https://discord.com/api/webhooks/1073755441592533002/73gJnK61b7W6sPht4uKDjNnDs--BtZw_5dIfVeYwxeR1Hga1SbsBkZRMr6jj0-Hj2Er5'
-- AddEventHandler('playerDropped', function(reason)
--     local _source = source
-- 	if (_source) then
-- 		zero.dropPlayer(_source, reason)

-- 		local user_id = zero.getUserId(_source)
-- 		if user_id then
-- 			if (reason == "Game crashed: gta-core-five.dll!CrashCommand (0x0)") then
-- 				zero.setBanned(user_id, true)
-- 				exports["gb_core"]:insertBanRecord(user_id,true,-1,"FORÇOU CRASH")
-- 				zero.webhook(webhookCrash, "```prolog\n[USER_ID]: "..user_id.."\n[UTILIZOU COMANDO _CRASH]"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").."```" )
-- 			end
-- 		end
-- 	end
-- end)