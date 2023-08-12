hotkeys = {
    [157] = 0,
    [158] = 1,
    [160] = 2,
    [164] = 3,
    [165] = 4
}

RegisterNuiCallback('sendItem', function(data)
    local nearestPlayer = zero.getNearestPlayer(2)

    if nearestPlayer ~= nil then
        sInventory.sendItem(nearestPlayer, data.item, data.amount)
    else
        config.functions.clientNotify(config.texts.notify_title, config.texts.notify_nearest_player, 5000)
    end
end)

RegisterNuiCallback('changeItemPosition', function(data)
    sInventory.changeItemPosition(data.cItem, data.cPos, data.nItem, data.nPos, data.amount)
end)

RegisterNuiCallback('useItem', function(data)
    if (LocalPlayer.state.BlockTasks and LocalPlayer.state.Handcuff) then return; end;
    sInventory.useItem(data.item, data.amount)
end)