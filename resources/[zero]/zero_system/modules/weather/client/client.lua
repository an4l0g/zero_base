local staticTime = false
local weather, hours, minutes = 'EXTRASUNNY', 7, 0

RegisterNetEvent('zero_weather:staticTime', function(data)
    staticTime = data
end)

RegisterNetEvent('zero_weather:syncTimers', function(data)
    weather = data['weather']; hours = data['hours']; minutes = data['minutes']
end)

Citizen.CreateThread(function()
    while true do
        if (type(staticTime) ~= 'table') then
            SetWeatherTypeNow(weather)
			SetWeatherTypePersist(weather)
			SetWeatherTypeNowPersist(weather)
            NetworkOverrideClockTime(hours, minutes, 00)
        else
            SetWeatherTypeNow(staticTime['weather'])
			SetWeatherTypePersist(staticTime['weather'])
			SetWeatherTypeNowPersist(staticTime['weather'])
            NetworkOverrideClockTime(staticTime['hours'], staticTime['minutes'], 00)
        end
        Citizen.Wait(100)
    end
end)