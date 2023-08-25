srv = {}
Tunnel.bindInterface(GetCurrentResourceName(), srv)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())

local configGeneral = config.general

local _active = {}

RegisterCommand('clearmultas', function(source, args)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.hasPermission(user_id, '+Staff.Administrador') and args[1] then
        local nUser = parseInt(args[1])
        local totalMultas = 0
        local query = zero.query('zero_bank/getMultas', { user_id = user_id })
        if (query) then
            for _, v in ipairs(query) do totalMultas = (totalMultas + v.fine_value); end;
            zero.execute('zero_bank/delAllMultas', { user_id = user_id })
            TriggerClientEvent('notify', source, 'Banco', 'Você apagou <b>R$'..zero.format(totalMultas)..'</b> de multa(s) do passaporte <b>'..nUser..'</b>.')
            zero.webhook('ClearFines', '```prolog\n[ZERO BANK]\n[ACTION]: (CLEAR FINES)\n[USER]: '..user_id..'\n[TARGET]: '..nUser..'\n[FINES VALUE]: '..zero.format(totalMultas)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
        end
    end
end)

RegisterCommand('multar', function(source)
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, { 'staff.permissao', 'policia.permissao' }) then
        local prompt = exports.zero_hud:prompt(source, {
            'Passaporte do jogador', 'Motivo da multa', 'Descrição da multa', 'Valor da multa'
        })

        if (prompt) and prompt[1] and prompt[2] and prompt[3] and prompt[4] then
            local nUser = parseInt(prompt[1])
            local Reason = prompt[2]
            local Description = prompt[3]
            local Value = parseInt(prompt[4])

            local nIdentity = zero.getUserIdentity(nUser)
            local request = exports.zero_hud:request(source, 'Você tem certeza que desja multar o '..nIdentity.firstname..' '..nIdentity.lastname..' em R$'..zero.format(Value)..'?', 60000)
            if (request) then
                multarPlayer(nUser, Reason, Value, Description)

                TriggerClientEvent('notify', source, 'Multa', 'Você aplicou uma multa de <b>R$'..zero.format(Value)..'</b> no <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>.')
                TriggerClientEvent('notify', zero.getUserSource(nUser), 'Multa', 'Você foi multado no valor de <b>R$'..zero.format(Value)..'</b>.')
            
                zero.webhook('Multar', '```prolog\n[ZERO BANK]\n[ACTION]: (FINE)\n[USER]: '..user_id..'\n[TARGET]: '..nUser..'\n[REASON]: '..Reason..'\n[DESCRIPTION]: '..Description..'\n[FINE VALUE]: '..zero.format(Value)..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..'\n```')        
            end
        end
    end
end)

RegisterNetEvent('zero_interactions:multar', function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and zero.checkPermissions(user_id, { 'staff.permissao', 'policia.permissao' }) then
        local prompt = exports.zero_hud:prompt(source, {
            'Passaporte do jogador', 'Motivo da multa', 'Descrição da multa', 'Valor da multa'
        })

        if (prompt) and prompt[1] and prompt[2] and prompt[3] and prompt[4] then
            local nUser = parseInt(prompt[1])
            local Reason = prompt[2]
            local Description = prompt[3]
            local Value = parseInt(prompt[4])

            local nIdentity = zero.getUserIdentity(user_id)
            local request = exports.zero_hud:request(source, 'Você tem certeza que desja multar o '..nIdentity.firstname..' '..nIdentity.lastname..' em R$'..zero.format(Value)..'?', 60000)
            if (request) then
                multarPlayer(nUser, Reason, Value, Description)

                TriggerClientEvent('notify', source, 'Multa', 'Você aplicou uma multa de <b>R$'..zero.format(Value)..'</b> no <b>'..nIdentity.firstname..' '..nIdentity.lastname..'</b>.')
                TriggerClientEvent('notify', zero.getUserSource(nUser), 'Multa', 'Você foi multado no valor de <b>R$'..zero.format(Value)..'</b>.')
            
                zero.webhook('Multar', '```prolog\n[ZERO BANK]\n[ACTION]: (FINE)\n[USER]: '..user_id..'\n[TARGET]: '..nUser..'\n[REASON]: '..Reason..'\n[DESCRIPTION]: '..Description..'\n[FINE VALUE]: '..zero.format(Value)..os.date('\n[DATE]: %d/%m/%Y [HOUR]: %H:%M:%S')..'\n```')        
            end
        end
    end
end)

srv.checkPermission = function(perm)
    local source = source
    local user_id = zero.getUserId(source)
    if (zero.checkPermissions(user_id, perm)) then
        return true
    end
    TriggerClientEvent('notify', source, 'Banco', 'Você não possui <b>acesso</b> para acessar este banco.')
    return false 
end

srv.playerInfo = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local identity = zero.getUserIdentity(user_id)
        if (identity) then
            local fullname = identity.firstname..' '..identity.lastname
            return zero.getMoney(user_id), zero.getBankMoney(user_id), fullname
        end
        return 0, 0, 'Indivíduo Indigente' 
    end
end

srv.updateMoney = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then return zero.getMoney(user_id), zero.getBankMoney(user_id); end;
end

local generate = { ganhou = 0, perdeu = 0 }

local _sinal = {
    ['+'] = function(valor)
        local db_valor = parseInt(splitString(valor, '$')[2])
        if (db_valor) then generate.ganhou = (generate.ganhou + (db_valor * 1000)); end;
    end,
    ['-'] = function(valor)
        local db_valor = parseInt(splitString(valor, '$')[2])
        if (db_valor) then generate.perdeu = (generate.perdeu + (db_valor * 1000)); end;
    end
}

srv.generateData = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local historico = (json.decode(zero.getUData(user_id, 'zero_bank:historico')) or {})
        local db_multas = zero.query('zero_bank/getMultas', { user_id = user_id })
        local rendimento_db = (json.decode(zero.getUData(user_id, 'zero_bank:rendimento')) or {})

        local multas = 0
        local rendimento = 0

        for _, v in pairs(historico) do
            if (v.value) then
                local sinal = splitString(v.value, 'R')[1]
                _sinal[sinal](v.value)
            end
        end

        if (rendimento_db) then
            for _, v in pairs(rendimento_db) do
                rendimento = (rendimento + v)
            end
        end

        for _, v in ipairs(db_multas) do
            multas = (multas + v.fine_value)
        end

        local total = (generate.ganhou + generate.perdeu + multas + rendimento)
        return generate.ganhou, generate.perdeu, multas, total, rendimento
    end
end

srv.transferir = function(id, value)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and not _active[user_id] then
        _active[user_id] = true
        local _identity = zero.getUserIdentity(id)
        if (user_id ~= id and _identity) then
            if (zero.tryBankPayment(user_id, value)) then
                zero.giveBankMoney(id, value)
                exports.zero_bank:extrato(user_id, 'Transferência', -value)
                exports.zero_bank:extrato(id, 'Transferência', value)
                zero.webhook('Transfer', '```prolog\n[ZERO BANK]\n[ACTION]: (TRANSFER)\n[USER]: '..user_id..'\n[TARGET]: '..id..'\n[VALUE]: '..zero.format(value)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
                TriggerClientEvent('bank_notify', source, 'sucesso', 'Banco', 'Você transferiu R$'..zero.format(value)..' para o passaporte '..id..'.')
            else
                TriggerClientEvent('bank_notify', source, 'negado', 'Banco', 'Você não possui essa quantia de dinheiro em sua conta bancária.')
            end
        else
            local text = (user_id == id and 'Você não pode transferir dinheiro para si mesmo.' or 'Este passaporte não existe em nossa cidade.')
            TriggerClientEvent('bank_notify', source, 'negado', 'Banco', text)
        end
        _active[user_id] = nil
    end
end

srv.sacar = function(value)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and not _active[user_id] then
        _active[user_id] = true
        if (zero.tryWithdraw(user_id, value)) then
            zero.webhook('Withdraw', '```prolog\n[ZERO BANK]\n[ACTION]: (WITHDRAW)\n[USER]: '..user_id..'\n[VALUE]: '..zero.format(value)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
            TriggerClientEvent('bank_notify', source, 'sucesso', 'Banco', 'Você sacou R$'..zero.format(value)..'.')
        else
            TriggerClientEvent('bank_notify', source, 'negado', 'Banco', 'Você não possui essa quantia de dinheiro em sua conta bancária.')
        end
        _active[user_id] = nil
    end
end

srv.depositar = function(value)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and not _active[user_id] then
        _active[user_id] = true
        if (zero.tryDeposit(user_id, value)) then
            zero.webhook('Deposit', '```prolog\n[ZERO BANK]\n[ACTION]: (DEPOSIT)\n[USER]: '..user_id..'\n[VALUE]: '..zero.format(value)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
            TriggerClientEvent('bank_notify', source, 'sucesso', 'Banco', 'Você depositou R$'..zero.format(value)..'.')
        else
            TriggerClientEvent('bank_notify', source, 'negado', 'Banco', 'Você não possui essa quantia de dinheiro em sua carteira.')
        end
        _active[user_id] = nil
    end
end

srv.giveRendimento = function()
    local source = source
    zero.antiflood(source, 'give:rendimento', 2)
    local user_id = zero.getUserId(source)
    if (user_id) then
        local users = zero.getUsers()
        for k, v in pairs(users) do
            local bankMoney = zero.getBankMoney(k)
            local rendimento = parseInt(bankMoney * configGeneral.income)
            if (rendimento > 0) then
                zero.giveBankMoney(k, rendimento)
                registerRendimento(k, rendimento)
                registerTrans(k, 'Rendimento', rendimento)
                TriggerClientEvent('bank_notify', v, 'sucesso', 'Poupança', 'Você recebeu R$'..zero.format(rendimento)..' pelos os seus investimentos.')
                zero.webhook('Income', '```prolog\n[ZERO BANK]\n[ACTION]: (RECEIVED INCOME)\n[USER]: '..user_id..'\n[VALUE RECEIVED]: '..zero.format(rendimento)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
            end
        end
    end
end

srv.getRendimento = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local data = (json.decode(zero.getUData(user_id, 'zero:rendimento')) or {})
        if (data) then return data; end;
    end
end

srv.getHistoricoBank = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local data = (json.decode(zero.getUData(user_id, 'zero_bank:historico')) or {})
        if (#data >= 20) then srv.clearTransferencia(source) end;
        if (data) then return data; end;
    end
end

srv.clearTransferencia = function(nsource)
    local source = source
    if (nsource) then source = nsource; end;
    local user_id = zero.getUserId(source)
    if (user_id) then
        zero.setUData(user_id, 'zero_bank:historico', json.encode({}))
    end
end

srv.getMultas = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local query = zero.query('zero_bank/getMultas', { user_id = user_id })
        if (query) then
            local multas = {}
            local totalMultas = 0
            for k, v in ipairs(query) do
                local currentYear = tonumber(os.date('%Y'))
                local temp = os.date('*t', tonumber(v.fine_time))
                local date = temp.day..'/'..temp.month..'/'..currentYear
                totalMultas = (totalMultas + v.fine_value)
                table.insert(multas, { id_multa = v.id, motivo = v.fine_reason, valor = v.fine_value, time = date, desc = v.fine_description })
            end
            return multas
        end
    end
end

srv.pagarMultas = function(id)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) and not _active[user_id] then
        _active[user_id] = true
        local query = zero.query('zero_bank/getMulta', { multa_id = id })[1]
        if (query) then
            if (zero.tryFullPayment(user_id, query.fine_value)) then
                zero.execute('zero_bank/delMulta', { user_id = user_id, multa_id = id })
                zero.webhook('PayFine', '```prolog\n[ZERO BANK]\n[ACTION]: (PAY FINE)\n[USER]: '..user_id..'\n[FINE VALUE]: '..zero.format(query.fine_value)..'\n[FINE ID]: '..query.id..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
                registerTrans(user_id, 'Multas', -query.fine_value)
                TriggerClientEvent('bank_notify', source, 'sucesso', 'Prefeitura', 'Multa Nº'..query.id..' paga com sucesso.')
            else
                TriggerClientEvent('bank_notify', source, 'negado', 'Prefeitura', 'Você não possui R$'..zero.format(query.fine_value)..' para pagar a multa Nº'..query.id..'.')
            end
        end
        _active[user_id] = nil
    end
end

srv.getPix = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local query = zero.query('zero_bank/getPix', { user_id = user_id })[1]
        if (query) then return query.chave; end;
    end
end

srv.createPix = function(key)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local query = zero.query('zero_bank/getPix', { user_id = user_id })[1]
        if (query) then
            TriggerClientEvent('bank_notify', source, 'negado', 'Pix', 'Você já possui uma <b>chave pix</b>.')
        else
            local check = zero.query('zero_bank/checkPix', { chave = key })[1]
            if (not check) then
                zero.execute('zero_bank/addPix', { user_id = user_id, chave = key })
                zero.webhook('CriarPix', '```prolog\n[ZERO BANK]\n[ACTION]: (CREATE PIX)\n[USER]: '..user_id..'\n[PIX]: '..key..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
                TriggerClientEvent('bank_notify', source, 'sucesso', 'Pix', 'Você criou a sua <b>chave pix</b>.')
            else
                TriggerClientEvent('bank_notify', source, 'negado', 'Pix', 'Esta <b>chave pix</b> já existe.')
            end
        end
    end
end

srv.editPix = function(key)
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local query = zero.query('zero_bank/getPix', { user_id = user_id })[1]
        if (query) then
            local check = zero.query('zero_bank/checkPix', { chave = key })[1]
            if (not check) then
                zero.execute('zero_bank/editPix', { user_id = user_id, chave = key })
                zero.webhook('EditPix', '```prolog\n[ZERO BANK]\n[ACTION]: (EDIT PIX)\n[USER]: '..user_id..'\n[NEW PIX]: '..key..'\n[OLD PIX]: '..query.chave..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
                TriggerClientEvent('bank_notify', source, 'sucesso', 'Pix', 'Você editou a sua <b>chave pix</b>.')
            else
                TriggerClientEvent('bank_notify', source, 'negado', 'Pix', 'Esta <b>chave pix</b> já existe.')
            end
        else
            TriggerClientEvent('bank_notify', source, 'negado', 'Pix', 'Você não possui uma <b>chave pix</b>.')
        end
    end
end

srv.removePix = function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local query = zero.query('zero_bank/getPix', { user_id = user_id })[1]
        if (query) then
            zero.execute('zero_bank/delPix', { user_id = user_id })
            zero.webhook('DelPix', '```prolog\n[ZERO BANK]\n[ACTION]: (DEL PIX)\n[USER]: '..user_id..'\n[DELETE PIX]: '..query.chave..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
            TriggerClientEvent('bank_notify', source, 'sucesso', 'Pix', 'Você deletou a sua <b>chave pix</b>.')
        else
            TriggerClientEvent('bank_notify', source, 'negado', 'Pix', 'Você não possui uma <b>chave pix</b>.')
        end
    end
end

AddEventHandler('vRP:playerSpawn',function(user_id, source, first_spawn)
    if (user_id) then
        local bank = zero.getBankMoney(user_id)
        local money = zero.getMoney(user_id)
        if (bank and money) then
            zero.webhook('MoneyJoin', '```prolog\n[ZERO BANK]\n[ACTION]: (MONEY JOIN)\n[USER]: '..user_id..'\n[WALLET]: '..zero.format(money)..'\n[BANK]: '..zero.format(bank)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
        end
    end
end)

AddEventHandler('playerDropped', function()
    local source = source
    local user_id = zero.getUserId(source)
    if (user_id) then
        local bank = zero.getBankMoney(user_id)
        local money = zero.getMoney(user_id)
        if (bank and money)  then
            zero.webhook('MoneyExit', '```prolog\n[ZERO BANK]\n[ACTION]: (MONEY EXIT)\n[USER]: '..user_id..'\n[WALLET]: '..zero.format(money)..'\n[BANK]: '..zero.format(bank)..os.date('\n[DATA]: %d/%m/%Y [HORA]: %H:%M:%S')..'\n```')
        end
    end
end)