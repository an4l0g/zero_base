local staticTime = false

RegisterNetEvent('zero_weather:staticTime', function(data)
    staticTime = data
end)

Citizen.CreateThread(function()
    while (true) do
        if (type(staticTime) ~= 'table') then
            SetWeatherTypeNow(GlobalState.weather)
            SetWeatherTypePersist(GlobalState.weather)
            SetWeatherTypeNowPersist(GlobalState.weather)
            NetworkOverrideClockTime(GlobalState.hours, GlobalState.minutes, 00)
        else
            SetWeatherTypeNow(staticTime['weather'])
            SetWeatherTypePersist(staticTime['weather'])
            SetWeatherTypeNowPersist(staticTime['weather'])
            NetworkOverrideClockTime(staticTime['hours'], staticTime['minutes'], 00)
        end
        Citizen.Wait(1000)
    end
end)