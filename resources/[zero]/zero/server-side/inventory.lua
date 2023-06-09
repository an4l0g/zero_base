vRP.computeItemsWeight = function(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end

vRP.giveInventoryItem = function(user_id,idname,amount)
	if user_id and idname and amount then
		exports.zero_inventory:giveInventoryItem(user_id, idname, amount)
	end
end

vRP.tryGetInventoryItem = function(user_id,idname,amount)
	if user_id and idname and amount then
		if exports.zero_inventory:tryGetInventoryItem(user_id, idname, amount) then
			return true
		end
	end
	return false
end

vRP.getInventoryItemAmount = function(user_id,idname)
	return exports.zero_inventory:getInventoryItemAmount(user_id, idname)
end

vRP.getInventory = function(user_id)
	local data = exports.zero_inventory:getInventory(user_id)
	if data then
		local old_format = {}
		for _,item in pairs(data) do
			if (not old_format[item.index]) then
				old_format[item.index] = { amount = item.amount }
			else
				old_format[item.index].amount = old_format[item.index].amount + item.amount
			end
		end
		return old_format
	end
end

vRP.getInventoryWeight = function(user_id)
	return exports.zero_inventory:getInventoryWeight(user_id)
end

vRP.getInventoryMaxWeight = function(user_id)
    return exports.zero_inventory:getInventoryMaxWeight(user_id) 
end

vRP.setInventoryMaxWeight = function(user_id,max)
    exports.zero_inventory:setInventoryMaxWeight(user_id, max)
end

vRP.varyInventoryMaxWeight = function(user_id,vary)
    local max = vRP.getInventoryMaxWeight(user_id)
    if max then
        vRP.setInventoryMaxWeight(user_id,max+vary)
    end
end

vRP.clearInventory = function(user_id)
	local source = vRP.getUserSource(user_id)
	if source then
		exports.zero_inventory:clearInventory(user_id)
		if not vRP.hasPermission(user_id,'mochila.permissao') then
			vRP.setInventoryMaxWeight(user_id, 6)
			SetPedComponentVariation(GetPlayerPed(source), 5, 0);
		end		
	end
end


local webhookdied = ""
vRP.itemBodyList = function(item)
	return exports.zero_inventory:getItemInfo(item) or {}
end

vRP.itemExists = function(item)
	return (vRP.itemBodyList(item).name ~= nil)
end

vRP.itemNameList = function(item)
	return vRP.itemBodyList(item).name
end

vRP.itemIndexList = function(item)
	return item
end

vRP.itemTypeList = function(item)
	return vRP.itemBodyList(item).type
end

vRP.getItemWeight = function(item)
	return (vRP.itemBodyList(item).weight or 0)
end

vRP.getItemDefinition = function(item)
    local data = vRP.itemBodyList(item)
	return data.name,(data.weight or 0)
end