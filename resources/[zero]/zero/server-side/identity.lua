------------------------------------------------------------------
-- GENERATE FUNCTIONS
------------------------------------------------------------------
zero.generateStringNumber = function(format)
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

zero.generateRegistrationNumber = function()
	local user_id = nil
	local registration = ''
	repeat
		registration = zero.generateStringNumber('LLDDDDLL')
		user_id = zero.getUserByRegistration(registration)
	until not user_id
	return registration
end

zero.generatePhoneNumber = function()
	local user_id = nil
	local phone = ''
	repeat
		phone = zero.generateStringNumber('DDD-DDD')
		user_id = zero.getUserByPhone(phone)
	until not user_id
	return phone
end
------------------------------------------------------------------

------------------------------------------------------------------
-- GET USER IDENTITY
------------------------------------------------------------------
local identidades = {}
zero.getUserIdentity = function(user_id)
    if (user_id) then
      	if (not identidades[user_id]) then identidades[user_id] = zero.query('vRP/get_user_identity', { user_id = user_id })[1] end
      	return identidades[user_id] 
    end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- GET USER BY REGISTRATION
------------------------------------------------------------------
local registros = {}
zero.getUserByRegistration = function(registration)
	if (registration) then
		if (not registros[registration]) then
			local rows = zero.query('vRP/get_userbyreg', { registration = (registration or '') })
			if rows[1] then
				registros[registration] = rows[1].user_id
			end
		end
		return registros[registration]
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- GET USER BY PLATE
------------------------------------------------------------------
local placa = {}
zero.getUserByPlate = function(plate)
	if (plate) then
		if (not placa[plate]) then
			local rows = zero.query('vRP/get_userbyplate', { plate = (plate or '') })
			if rows[1] then
				placa[plate] = rows[1].user_id
			end
		end
		return placa[plate]
	end
end
------------------------------------------------------------------

------------------------------------------------------------------
-- GET USER BY PHONE
------------------------------------------------------------------
local telefones = {}
zero.getUserByPhone = function(phone)
	if (phone) then
    	if (not telefones[phone]) then
			local rows = zero.query("vRP/get_userbyphone",{ phone = (phone or '') })
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
zero.resetIdentity = function(user_id)
	local idt = (identidades[user_id] or zero.getUserIdentity(user_id))
	if (idt) then
		if (registros[idt.registration]) then registros[idt.registration] = nil end
		if (telefones[idt.phone]) then telefones[idt.phone] = nil end
	end
	identidades[user_id] = nil 
end
------------------------------------------------------------------

AddEventHandler('vRP:playerJoin', function(user_id, source, name)
	if (not zero.getUserIdentity(user_id)) then
		zero.execute('vRP/init_user_identity', {
			user_id = user_id,
			registration = zero.generateRegistrationNumber(),
			phone = zero.generatePhoneNumber(),
			firstname = 'Individuo',
			lastname = 'Indigente',
			age = 18
		})
	end
end)

AddEventHandler('vRP:playerSpawn', function(user_id, source, first_spawn)
	local identity = zero.getUserIdentity(user_id)
	if (identity) then
		zeroClient._setRegistrationNumber(source, (identity.registration or 'AA000AAA'))
	end
end)