local srv = {}
Tunnel.bindInterface('Dealership', srv)
local vCLIENT = Tunnel.getInterface('Dealership')

zero._prepare('zero_dealership/createStock', 'insert ignore into dealership (car, stock) values (@car, @stock)')
zero._prepare('zero_dealership/getAll', 'select * from dealership')
zero._prepare('zero_dealership/getVehStock', 'select stock from dealership where car = @car')
zero._prepare('zero_dealership/updateVehStock', 'update dealership set stock = @stock where car = @car')

local addVehicles = {
    'nissanskyliner34',
    'lancerevolution9',
    'lancerevolutionx',
    '21Charscat',
    'a80',
    'bmwm4gts',
    'bmwe39',
    'amarok',
    'maxima22',
    'nis15',
    'fk8',
    'golfrebaixado',
    'auditt',
    'rmodr8c',
    'q820',
    'rmodgt63',
    'zn20',
    'xj6',
    'rmodrs6',
    'hornet',
    '911r',
    'r1200',
    'h2carb',
    'merc23',
    'mt09black',
    'africat',
    'nissanr33tbk',
    'z1000',
    'bmws',
    'tiger1200',
    'tenere1200',
    'ram1500',
    'velar',
    'urus',
    '19raptor',
    'tiger',
    'cbb',
    'rmodskyline34',
    'silvia',
    'rmodbolide',
    '718b',
    'rmodgtr50',
    'sennagtr',
    '458spider',
    '720s18',
    'teslaprior',
    'gxlaferrari',
    'jeslbwk',
    'ferrariitalia',
    'bf400',
    'akuma',
    'hakuchou',
    'shotaro',
    'faggio',
    'manchez',
    'sanchez2',
    'gauntlet4',
    'deviant',
    'moonbeam2',
    'vigero',
    'slamvan3',
    'gauntlet',
    'dominator3',
    'buccaneer2',
    'everon',
    'sandking2',
    'dubsta3',
    'caracara2',
    'kamacho',
    'baller4',
    'baller6',
    'novak',
    'rebla',
    'toros',
    'xls2',
    'contender',
    'cognoscenti2',
    'glendale2',
    'tailgater2',
    'superd',
    'primo2',
    'coquette4',
    'drafter',
    'elegy',
    'jugular',
    'neon',
    'paragon2',
    'lynx',
    'penumbra2',
    'sultan2',
    'sugoi',
    'jester4',
    'euros',
    'futo2',
    'vectre',
    'comet6',
    'growler',
    'cypher',
    'rt3000',
    'remus',
    'zr350',
    'turismo2',
    'cheburek',
    'savestra',
    'infernus2',
    'autarch',
    'italigtb',
    'xa21',
    'sultanrs',
    't20',
    'osiris',
    'nero2',
    'entity3',
    'prototipo',
    'emerus',
    'visione',
    'zentorno',
    'sadler',
    'schlagen',
    'komoda',
    'diablous2',
    'previon',
    'windsor',
    'f620',
    'weevil',
    'asbo',
    'brioso',
    'kanjo'
}

-- Citizen.CreateThread(function()
--     for k, v in pairs(addVehicles) do
--         zero.execute('zero_dealership/createStock', {
--             car = v,
--             stock = 100
--         })
--         print('^5[Zero Dealership]^7 add '..v..' / stock 100')
--     end
-- end)

srv.getStock = function()
    local query = zero.query('zero_dealership/getAll')
    if (query) then
        local allVehicles = {}
        for _, v in pairs(query) do
            local vehicleInfos = { vname = vehicleName(v.car), vmaker = vehicleMaker(v.car), vtype = vehicleType(v.car), vtrunk = vehicleSize(v.car), price = vehiclePrice(v.car), engine = 1000, body = 1000, fuel = 100 }
            table.insert(allVehicles, {
                type = vehicleInfos.vtype,
                spawn = v.car,
                name = vehicleInfos.vname,
                maker = vehicleInfos.vmaker,
                trunk_capacity = vehicleInfos.vtrunk, 
                engine = vehicleInfos.engine, 
                breaker = 100, 
                transmission = 100, 
                suspension = 100,
                fuel = vehicleInfos.fuel,
                stock = v.stock,
                price = vehicleInfos.price
            })
        end
        return allVehicles
    end
end

srv.buyVehicle = function(vehicle)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local verifyVehicle = zero.query('zero_garage/getVehiclePlate', { user_id = user_id, vehicle = vehicle })[1]
        if (verifyVehicle) then TriggerClientEvent('notify', source, 'Concessionára', 'Você já possui este <b>veículo</b> em sua garagem.') return; end;

        local query = zero.query('zero_dealership/getVehStock', { car = vehicle })[1]
        if (query) then
            local _config = config.vehicles[vehicle]
            if (_config.type == 'vip') then return; end;
            if (_config) then
                if (_config.price > 0) then
                    if (zero.tryFullPayment(user_id, _config.price)) then
                        exports.zero_bank:extrato(user_id, 'Concessionária', -_config.price)
                        addVehicle(user_id, vehicle, 0)
                        TriggerClientEvent('notify', source, 'Concessionária', 'Sua compra foi <b>efetuada</b> com sucesso. Parabéns pela a sua nova requisiçao! O <b>'.._config.name..'</b> já se encontra em sua garagem.')
                        zero.execute('zero_dealership/updateVehStock', { stock = parseInt(query.stock - 1), car = vehicle })
                        zero.webhook('buyVehicle', '```prolog\n[DEALERSHIP]\n[ACTION] (BUY VEHICLE)\n[USER]: '..user_id..'\n[VEHICLE SPAWN]: '..vehicle..'\n[VEHICLE NAME] '.._config.name..'\n[VEHICLE MAKER]: '.._config.maker..'\n[PRICE]: '..zero.format(_config.price)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..' \r```')
                    else
                        TriggerClientEvent('notify', source, 'Concessionária', 'Dinheiro <b>insuficiente</b>.')
                    end
                end
            end
        end
    end
end

local inTest = {}
srv.testDrive = function(vehicle)
    local source = source
    local user_id = zero.getUserId(source)
    if user_id then
        if not (inTest[user_id]) then
            local ply = GetPlayerPed(source)
            inTest[user_id] = {
                bucket = GetPlayerRoutingBucket(source),
                origin = GetEntityCoords(ply),
                health = GetEntityHealth(ply)
            }

            SetPlayerRoutingBucket(source, parseInt(1000 + user_id))
            vCLIENT.startTest(source, vehicle)
        end
    end
end

srv.exitTestDrive = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and inTest[user_id] then
        zeroClient.killComa(source)
        zeroClient.setHealth(source, inTest[user_id].health)
        SetPlayerRoutingBucket(source, inTest[user_id].bucket)
        SetEntityCoords(GetPlayerPed(source), inTest[user_id].origin)
        inTest[user_id] = nil
    end
end

RegisterNetEvent('zero_garage:CacheExecute', function(source, user_id, quit)
    SetPlayerRoutingBucket(source, 0)
    local health = inTest[user_id].health
    local coord = inTest[user_id].origin
    if (inTest[user_id]) then
        if (quit) then
            zero.setKeyDataTable(user_id, 'position', { x = coord.x, y = coord.y, z = coord.z })
            zero.updateHealth(health)
        else
            zeroClient.teleport(source, coord.x, coord.y, coord.z)
            zeroClient.killComa(source)
            zeroClient.setHealth(source, health)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
  	if (GetCurrentResourceName() == resourceName) then 
		print('^5[Zero Garage]^7 sistema stopado/reiniciado.')
        for k, _ in pairs(inTest) do
            local user_id = k
            local _source = zero.getUserSource(user_id)
            if (user_id) then
                TriggerEvent('zero_garage:CacheExecute', _source, k)
                TriggerClientEvent('notify', _source, 'Concessionária', 'O sistema de <b>garagem</b> da nossa cidade foi reiniciado.')
                print('^5[Zero Dealership]^7 o user_id ^5('..user_id..')^7 foi retirado de dentro do test drive.')
                inTest[user_id] = nil
            end
        end
	end
end)

AddEventHandler('zero:playerLeave', function(user_id, source)
	if (inTest[user_id]) then
        TriggerEvent('zero_garage:CacheExecute', source, user_id, true)
        print('^5[Zero Dealership]^7 o user_id ^5('..user_id..')^7 foi retirado de dentro do test drive.')
        inTest[user_id] = nil
    end
end)