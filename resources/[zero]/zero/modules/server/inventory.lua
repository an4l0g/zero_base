zero.computeItemsWeight = function(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = zero.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end
vRP.computeItemsWeight = zero.computeItemsWeight

zero.giveInventoryItem = function(user_id,idname,amount)
	if user_id and idname and amount then
		exports.zero_inventory:giveInventoryItem(user_id, idname, amount)
	end
end
vRP.giveInventoryItem = zero.giveInventoryItem

zero.tryGetInventoryItem = function(user_id,idname,amount)
	if user_id and idname and amount then
		if exports.zero_inventory:tryGetInventoryItem(user_id, idname, amount) then
			return true
		end
	end
	return false
end
vRP.tryGetInventoryItem = zero.tryGetInventoryItem

zero.getInventoryItemAmount = function(user_id,idname)
	return exports.zero_inventory:getInventoryItemAmount(user_id, idname)
end
vRP.getInventoryItemAmount = zero.getInventoryItemAmount

zero.getInventory = function(user_id)
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
vRP.getInventory = zero.getInventory

zero.getInventoryWeight = function(user_id)
	return exports.zero_inventory:getInventoryWeight(user_id)
end
vRP.getInventoryWeight = zero.getInventoryWeight

zero.getInventoryMaxWeight = function(user_id)
    return exports.zero_inventory:getInventoryMaxWeight(user_id) 
end
vRP.getInventoryMaxWeight = zero.getInventoryMaxWeight

zero.setInventoryMaxWeight = function(user_id,max)
    exports.zero_inventory:setInventoryMaxWeight(user_id, max)
end
vRP.setInventoryMaxWeight = zero.setInventoryMaxWeight

zero.varyInventoryMaxWeight = function(user_id,vary)
    local max = zero.getInventoryMaxWeight(user_id)
    if max then
        zero.setInventoryMaxWeight(user_id,max+vary)
    end
end
vRP.varyInventoryMaxWeight = zero.varyInventoryMaxWeight

zero.clearInventory = function(user_id)
	local source = zero.getUserSource(user_id)
	if source then
		local Alianca = (zero.getInventoryItemAmount(user_id, 'alianca-casamento') > 0)

		exports.zero_inventory:clearInventory(user_id)

		if (Alianca) then zero.giveInventoryItem(user_id, 'alianca-casamento', 1); end;
		
		if not zero.hasPermission(user_id,'mochila.permissao') then
			zero.setInventoryMaxWeight(user_id, 6)
		end		
	end
end
vRP.clearInventory = zero.clearInventory

zero.itemBodyList = function(item)
	return exports.zero_inventory:getItemInfo(item) or {}
end
vRP.itemBodyList = zero.itemBodyList

zero.itemExists = function(item)
	return (zero.itemBodyList(item).name ~= nil)
end
vRP.itemExists = zero.itemExists

zero.itemNameList = function(item)
	return zero.itemBodyList(item).name
end
vRP.itemNameList = zero.itemNameList

zero.itemIndexList = function(item)
	return item
end
vRP.itemIndexList = zero.itemIndexList

zero.itemTypeList = function(item)
	return zero.itemBodyList(item).type
end
vRP.itemTypeList = zero.itemTypeList

zero.getItemWeight = function(item)
	return (zero.itemBodyList(item).weight or 0)
end
vRP.getItemWeight = zero.getItemWeight

zero.getItemDefinition = function(item)
    local data = zero.itemBodyList(item)
	return data.name,(data.weight or 0)
end
vRP.getItemDefinition = zero.getItemDefinition