cInventory.getWeaponsBag = function()
    local weapons = zero.getWeapons()
    local formattedWeapons = {}

    for k,v in pairs(weapons) do
        local currentItem = config.items[string.lower(k)]
        if currentItem then 
            table.insert(formattedWeapons, {
                index = k,
                name = currentItem.name,
                ammo = v.ammo
            })
        end
    end

    return formattedWeapons
end

cInventory.unequipAllWeapons = function()
    local weapons = zero.getWeapons()

    for k,v in pairs(weapons) do
        cInventory.unequipWeapon(k)
    end
end

cInventory.removeWeapons = function()
    local ped = PlayerPedId()
    RemoveAllPedWeapons(ped, true)
end


cInventory.addAmmo = function(index, amount)
    AddAmmoToPed(PlayerPedId(), index, tonumber(amount))
end

cInventory.unequipWeapon = function(index)
    local playerPed = PlayerPedId()
    local weaponHash = GetHashKey(string.upper(index))
    local ammoCount = GetAmmoInPedWeapon(playerPed, weaponHash)
    
    RemoveWeaponFromPed(playerPed, weaponHash)
    sInventory.giveInventoryItem(0, string.lower(index), 1)
    
    if ammoCount > 0 then
        SetPedAmmo(playerPed, weaponHash, 0)
        sInventory.giveInventoryItem(0, string.lower('m_'..index), ammoCount)
    end
    cInventory.closeInventory()
    config.functions.clientNotify(config.texts.notify_title, config.texts.notify_unequip_weapon(config.items[string.lower(index)].name), 5000)
end 

RegisterNuiCallback('unequipWeapon', function(data)
    cInventory.unequipWeapon(data.index)
end)