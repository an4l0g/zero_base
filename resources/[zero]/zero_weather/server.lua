local weathersConfig = config.weathers

local freezetime = false
local newWeather = 0
local weather, hours, minutes = 'EXTRASUNNY', 7, 0

local sourceVerification = function(source)
    local allow = false
    if (source == 0) then 
        allow = true
    else
        allow = zero.hasPermission(zero.getUserId(source), 'dono.permissao')
    end
    return allow 
end

local generateWeather = function()
    ::generateWeatherAgain::
    local weatherRandom = math.random(10)
    if (weathersConfig[weatherRandom].blacklist) then
        local blacklistRandom = math.random(100)
        if (blacklistRandom >= 50) then 
            goto generateWeatherAgain
        end  
    end
    weather = weathersConfig[weatherRandom].name
    print('Clima da cidade ^5Zero Roleplay^7 alterado para ^5'..weather..'^7.')
end

RegisterCommand('time', function(source, args)
    local allow = sourceVerification(source)
    if (allow) then
        if (args[1]) then
            if (not args[2]) then args[2] = 0; end;
            hours, minutes = parseInt(args[1]), parseInt(args[2]);
            if (source ~= 0) then TriggerClientEvent('notify', source, 'Clima', 'O <b>horário da cidade</b> foi alterado com sucesso!'); end;
            print('Tempo da cidade ^5Zero Roleplay^7 alterado para ^5'..hours..':'..minutes..'^7.')
        end
    end
end)

RegisterCommand('freezetime', function(source)
    local allow = sourceVerification(source)
    if (allow) then
        freezetime = (not freezetime)
        if (source ~= 0) then TriggerClientEvent('notify', source, 'Clima', 'O tempo foi <b>'..(freezetime == true and 'congelado' or 'descongelado')..'</b> com sucesso!'); end;
        print('Tempo da cidade ^5Zero Roleplay^7 foi ^5'..(freezetime == true and 'congelado' or 'descongelado')..'^7.')
    end
end)

RegisterCommand('weather', function(source, args)
    local allow = sourceVerification(source)
    if (allow) then
        if (args[1]) then
            weather = string.upper(args[1])
            if (source ~= 0) then TriggerClientEvent('notify', source, 'Clima', 'O clima foi <b>alterado</b> com sucesso!'); end;
            print('Clima da cidade ^5Zero Roleplay^7 alterado para ^5'..weather..'^7.')
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        if (newWeather == 0) then generateWeather(); newWeather = 30; end;
        newWeather = parseInt(newWeather - 1)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if (not freezetime) then
            minutes = (parseInt(minutes) + 1)
            if (minutes >= 60) then 
                minutes = 0; hours = (parseInt(hours) + 1);
                if (hours >= 24) then hours = 0; end;
            end
        end
        TriggerClientEvent('zero_weather:syncTimers', -1, {
            weather = weather, hours = hours, minutes = minutes
        })
    end
end)