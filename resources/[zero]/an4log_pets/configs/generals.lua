Proxy = module("zero","lib/Proxy")
zero = Proxy.getInterface("zero")

configs = {}
configs.token = 'ZeroToken'
configs.generals = {
    openCommand = 'pets',
    dbTable = 'pets', -- Nome da tabela do banco de dados
    notifyTime = 5000, -- Tempo que a noticação vai ficar na tela
    foodAndWaterTime = 5000, -- Tempo que o personagem vai ficar alimentando e dando agua pro pet
    hungerPercentToDisable = 30, -- Porcentagem de fome para desabilitar pet
    thirstPercentToDisable = 40, -- Porcentagem de sede para desabilitar pet
    distanceToFeed = 2.0, -- Distancia para alimentar o pet
    hungerDecrement = -5, -- Quantidade de fome que será adicionado por tempo
    foodIncrement = 50, -- Quantidade de fome que será adicionado por tempo
    thirstDecrement = -2, -- Quantidade de sede que será adicionado por tempo
    waterIncrement = 50, -- Quantidade de fome que será adicionado por tempo
    timeToDecrementStatus = 180000, -- Tempo para decrementar fome e sete
    enableAttack = true, -- Habilitar mecânicas de ataque
    disableFireGun = false, -- Desabilitar arma quando o pet estiver ativo
}

configs.funcs = {
    getPlayerID = function(source)
        return zero.getUserId(source)
    end,
    giveItem = function(source, item, amount)
        local user_id = zero.getUserId(source)
        zero.giveInventoryItem(user_id, item, amount)
    end,
    giveWeapon = function(weapon, ammo)
        zero.giveWeapons({ [weapon] = { ammo = ammo }},false, GlobalState.weaponToken)
    end,
    tryGetItem = function(source, item, amount)
        local user_id = zero.getUserId(source)
        return zero.tryGetInventoryItem(user_id, item, amount)
    end,
    clientNotify = function(msg_type, title, msg, time)
        TriggerEvent('notify', title, msg, time)  
    end,
    serverNotify = function(source, msg_type, title, msg, time)
        TriggerClientEvent('notify', source, title, msg, time)  
    end,
    progressBar = function(text, time)
        TriggerEvent('progressBar', text, time)
    end
}

configs.keyMap = {
    attack = {
        key = 'q',
        label = 'Atacar',
    },
    goHome = {
        key = 'h',
        label = 'Ir para casa',
    },
    catchBall = {
        key = 'z',
        label = 'Pegar bolinha',
    },
    followMe = {
        key = 'f7',
        label = 'Seguir',
    },
    sit = {
        key = 'f9',
        label = 'Sentar',
    },
    liedown = {
        key = 'f11',
        label = 'Deitar',
    },
}