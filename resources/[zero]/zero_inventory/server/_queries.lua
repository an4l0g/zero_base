bagsTable = 'zero_inventory'
zero.prepare('zero_inventory:getBag', 'select * from '..bagsTable..' where bag_type = @bag_type')
zero.prepare('zero_inventory:insertBag', 'insert into '..bagsTable..' (slots, bag_type, weight) values (@slots, @bag_type, @weight)')
zero.prepare('zero_inventory:updateBag', 'insert into '..bagsTable..' (slots, bag_type) values (@slots, @bag_type) on duplicate key update slots = @slots')
zero.prepare('zero_inventory:updateBagWeight', 'update '..bagsTable..' set weight = @weight where bag_type = @bag_type')
zero.prepare('zero_inventory:updateBagWithoutId', 'insert into '..bagsTable..' (slots, bag_type) values (@slots, @bag_type) on duplicate key update slots = @slots')
zero.prepare('zero_inventory:deleteBag', 'delete from '..bagsTable..' where bag_type = @bag_type')