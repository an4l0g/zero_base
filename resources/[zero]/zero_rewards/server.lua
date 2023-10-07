sRewards = {}
exclusiveVehicle = false

zero.prepare('zero_rewards/save', 'insert into '..config.tableName..' (user_id, online_time, rewards) values (@user_id, @online_time, @rewards) ON DUPLICATE KEY UPDATE online_time = @online_time, rewards = @rewards')
zero.prepare('zero_rewards/get', 'select * from '..config.tableName..' where user_id = @user_id')
zero.prepare('zero_rewards/increment', 'UPDATE '..config.tableName..' SET rewards = rewards + @rewards_amount WHERE user_id = @user_id;')
zero.prepare('zero_rewards/getRank', 'select * from '..config.tableName..' order by online_time desc limit 7')
zero.prepare('zero_rewards/getImage', 'select * from identity where user_id = @user_id')

Tunnel.bindInterface('zero_rewards', sRewards)
cRewards = Tunnel.getInterface('zero_rewards')

generateNumber = function()
    return math.random(0, config.maxChance)
end

fullName = function(id)
    return id.firstname..' '..id.lastname
end

addCarToUser = function(source, reward)
    local user_id = zero.getUserId(source)
    local result = false
    if not exclusiveVehicle then
        if reward.spawn == config.exclusiveVehicle then
            exclusiveVehicle = true
        end
        if not exports.zero_garage:hasVehicle(user_id, reward.spawn) then
            exports.zero_garage:addVehicle(user_id, reward.spawn)
            zero.formatWebhook('https://discord.com/api/webhooks/1158247083443232870/1yL-_F-7_g1_9lsvKbCZJsNWCHb80IqctP-KVf4jeUyWW-_nH7vjZKkaEUMQd_7HJGpd', '/ONLINE', {
                { 'ID', user_id },
                { 'Carro', reward.spawn },
            })
            TriggerClientEvent('notify', source, '/online', 'O veículo '..reward.name..' foi adicionado à sua garagem!')
            result = true
        else
            TriggerClientEvent('notify', source, '/online', 'Você já possui esse veículo!')
            result = false
        end
        local userIdentity = zero.getUserIdentity(user_id)
        TriggerClientEvent('chatMessage', -1, '[ONLINE] ', { 0, 153, 255 }, fullName(userIdentity)..' ganhou um 🚗 '..reward.name..'!')
        return false
    else
        TriggerClientEvent('notify', source, '/online', 'O veículo exclusivo já foi resgatado por outro cidadão!')
        return false
    end
end

addItemToUser = function(source, reward)
    local user_id = zero.getUserId(source)
    local userIdentity = zero.getUserIdentity(user_id)
    zero.giveInventoryItem(user_id, reward.index, reward.amount)
    zero.formatWebhook('https://discord.com/api/webhooks/1158246327050833991/U7gshFzUH6S6LWtIxwSZIiknKNY3J4DX1EWZWOwNGigWs9FOjaedLg_v5d7zN2-qJAEv', '/ONLINE', {
        { 'ID', user_id },
        { 'Nome do Item', reward.name },
        { 'Quantidade', reward.amount },
    })
    TriggerClientEvent('notify', source, '/online', 'Você ganhou '..reward.amount..' <b>'..reward.name..'</b>!')
    TriggerClientEvent('chatMessage', -1, '[ONLINE] ', { 0, 153, 255 }, fullName(userIdentity)..' ganhou '..reward.amount..' 🎒 '..reward.name..'!')
end

removeReward = function(playerData)
    zero.execute('zero_rewards/save', { 
        user_id = playerData.user_id, 
        rewards = playerData.rewards - 1, 
        online_time = playerData.online_time
    })
end

sRewards.openBox = function()
    local _source = source
    local user_id = zero.getUserId(_source)
    local playerData = sRewards.getPlayerData(user_id)
    
    if playerData and playerData.rewards > 0 then
        local currentChance = generateNumber()
        local currentRewardType = nil
        for k,v in pairs(config.rewards) do
            if currentChance >= v.chances.min and currentChance <= v.chances.max then
                currentRewardType = v
            end
        end

        local currentCategoryChance = math.random(1, #currentRewardType.items)

        local currentReward = currentRewardType.items[currentCategoryChance]
        
        if currentReward.type == 'car' then
            if addCarToUser(_source, currentReward) then
                removeReward(playerData)
            end
        end
        
        if currentReward.type == 'item' then
            addItemToUser(_source, currentReward)
            removeReward(playerData)
        end
        sRewards.openOrUpdate(_source)
    else 
        TriggerClientEvent('notify', _source, '/online', 'Você não possui recompensas pendentes!')
    end
end

sRewards.getPlayerData = function(user_id)
    return zero.query('zero_rewards/get', { user_id = user_id })[1]
end

sRewards.registerTime = function()
    local _source = source
    local user_id = zero.getUserId(_source)
    local playerData = sRewards.getPlayerData(user_id)

    if playerData then
        zero.execute('zero_rewards/save', { 
            user_id = user_id, 
            rewards = playerData.rewards, 
            online_time = playerData.online_time + config.registerTime 
        })
    else 
        zero.execute('zero_rewards/save', { 
            user_id = user_id, 
            rewards = 0, 
            online_time = config.registerTime 
        })
    end
end

sRewards.addReward = function()
    local _source = source
    local user_id = zero.getUserId(_source)
    local playerData = sRewards.getPlayerData(user_id)

    zero.execute('zero_rewards/save', { 
        user_id = user_id, 
        rewards = playerData.rewards + 1, 
        online_time = playerData.online_time 
    })
    TriggerClientEvent('notify', _source, '/online', '🎁 Você tem 1 nova recompensa para resgatar no <b>/online</b>!')
end

sRewards.getRank = function()
    local players = zero.query('zero_rewards/getRank')
    
    if #players > 0 then
        for k,v in pairs(players) do
            local userImage = zero.query('zero_rewards/getImage', { user_id = v.user_id })[1]
            local identity = zero.getUserIdentity(v.user_id)
            if userImage then
                players[k].image = userImage.url
                players[k].name = identity.firstname..' '..identity.lastname
            end
        end

        return players
    end
    return {}
end

RegisterCommand('rewardstoall', function(source, args)
    local rewardsAmount = args[1]

    local request = exports.zero_hud:request(source, 'Você deseja realmente adicionar '..rewardsAmount..' recompensas para todos online?', 20000)
    
    if request then
        local players = zero.getUsers()
        for k, v in pairs(players) do
            local nSource = zero.getUserSource(parseInt(k))
            local nUser = zero.getUserId(nSource)
            if (nSource) then
                zero.execute('zero_rewards/increment', { 
                    user_id = nUser, 
                    rewards_amount = rewardsAmount, 
                })
                TriggerClientEvent('notify', nSource, '/online', 'Você acabou de receber '..rewardsAmount..' recompensas da prefeitura! <b>Utilize o /online para resgatá-las.</b>')
            end
        end
    end
end)

sRewards.openOrUpdate = function(source)
    cRewards.open(source, {
        action = 'open',
        rank = sRewards.getRank(),
        rewards = sRewards.getPlayerData(zero.getUserId(source)).rewards or 0
    })
end

RegisterCommand('online', function(source, args)
    sRewards.openOrUpdate(source)
end)