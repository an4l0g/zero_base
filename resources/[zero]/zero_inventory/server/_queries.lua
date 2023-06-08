bagsTable = 'zero_inventory'
sqls = {
    vRP.prepare('zero_inventory:getBag', 'select * from '..bagsTable..' where bag_type = @bag_type'),
    vRP.prepare('zero_inventory:insertBag', 'insert into '..bagsTable..' (slots, bag_type, weight) values (@slots, @bag_type, @weight)'),
    vRP.prepare('zero_inventory:updateBag', 'insert into '..bagsTable..' (slots, bag_type) values (@slots, @bag_type) on duplicate key update slots = @slots'),
    vRP.prepare('zero_inventory:updateBagWeight', 'update '..bagsTable..' set weight = @weight where bag_type = @bag_type'),
    vRP.prepare('zero_inventory:updateBagWithoutId', 'insert into '..bagsTable..' (slots, bag_type) values (@slots, @bag_type) on duplicate key update slots = @slots'),
    vRP.prepare('zero_inventory:deleteBag', 'delete from '..bagsTable..' where bag_type = @bag_type'),
}