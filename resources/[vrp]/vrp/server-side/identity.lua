------------------------------------------------------------------
-- GENERATE FUNCTIONS
------------------------------------------------------------------
vRP.generateStringNumber = function(format)
	local abyte = string.byte('A')
	local zbyte = string.byte('0')
	local number = ''
	for i = 1, #format do
		local char = string.sub(format,i,i)
    	if char == 'D' then number = number..string.char(zbyte+math.random(0,9))
		elseif char == 'L' then number = number..string.char(abyte+math.random(0,25))
		else number = number..char end
	end
	return number
end

vRP.generateRegistrationNumber = function()
	local user_id = nil
	local registration = ''
	repeat
		registration = vRP.generateStringNumber('LLDDDDLL')
		user_id = vRP.getUserByRegistration(registration)
	until not user_id
	return registration
end

vRP.generatePhoneNumber = function()
	local user_id = nil
	local phone = ''
	repeat
		phone = vRP.generateStringNumber('DDD-DDD')
		user_id = vRP.getUserByPhone(phone)
	until not user_id
	return phone
end
------------------------------------------------------------------

------------------------------------------------------------------
-- GET USER IDENTITY
------------------------------------------------------------------
local identidades = {}
vRP.getUserIdentity = function(user_id)
    if (user_id) then
      	if (not identidades[user_id]) then identidades[user_id] = vRP.query('vRP/get_user_identity', { user_id = user_id })[1] end
      	return identidades[user_id] 
    end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- GET USER BY REGISTRATION
------------------------------------------------------------------
local registros = {}
vRP.getUserByRegistration = function(registration)
	if (registration) then
		if (not registros[registration]) then
			local rows = vRP.query('vRP/get_userbyreg', { registration = registration or '' })
			if rows[1] then
				registros[registration] = rows[1].user_id
			end
		end
		return registros[registration]
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- GET USER BY PHONE
------------------------------------------------------------------
local telefones = {}
vRP.getUserByPhone = function(phone)
	if (phone) then
    	if (not telefones[phone]) then
			local rows = vRP.query("vRP/get_userbyphone",{ phone = phone or "" })
			if rows[1] then
				telefones[phone] = rows[1].user_id
			end
		end
		return telefones[phone]
    end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- RESET IDENTITY
------------------------------------------------------------------
vRP.resetIdentity = function(user_id)
	local idt = (identidades[user_id] or vRP.getUserIdentity(user_id))
	if (idt) then
		if (registros[idt.registration]) then registros[idt.registration] = nil end
		if (telefones[idt.phone]) then telefones[dt.phone] = nil end
	end
	identidades[user_id] = nil 
end
------------------------------------------------------------------

AddEventHandler('vRP:playerJoin', function(user_id, source, name)
	if (not vRP.getUserIdentity(user_id)) then
		vRP.execute('vRP/init_user_identity', {
			user_id = user_id,
			registration = vRP.generateRegistrationNumber(),
			phone = vRP.generatePhoneNumber(),
			firstname = 'Individuo',
			lastname = 'Indigente',
			age = 18
		})
	end
end)

AddEventHandler('vRP:playerSpawn', function(user_id, source, first_spawn)
	local identity = vRP.getUserIdentity(user_id)
	if (identity) then
		vRPclient._setRegistrationNumber(source, (identity.registration or 'AA000AAA'))
	end
end)