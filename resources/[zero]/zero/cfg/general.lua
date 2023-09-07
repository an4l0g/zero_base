config.maxPlayers = GetConvarInt('sv_maxclients')

config.priorityGroups = {
  ['Staff'] = 500,
  ['Priority100'] = 100,
  ['Priority75'] = 75,
  ['Priority50'] = 50,
  ['Priority25'] = 25,
  ['Priority10'] = 10
}

config.maintenanceMode = false
config.maintenanceGroups = {
  ['Staff'] = true
}

config.language = {
  maintenance = function(name)
    return '['..cityInformations.name..']\n\nOlá '..name..', o servidor se encontra em manutenção nesse exato momento, volte mais tarde!\nMais informações em nosso discord: '..cityInformations.discord
  end,
  joining = function(name)
    return '['..cityInformations.name..']\n\nOlá '..name..', você está entrando na cidade...'
  end,
  connecting = function(name)
    return '['..cityInformations.name..']\n\nOlá '..name..', você está se conectando em nossa cidade...'
  end,
  connectingError = function(name)
    if not (name) then name = 'user' end;
    return '['..cityInformations.name..']\n\nOlá '..name..', não foi possível adicioná-lo na fila.\n\nNosso discord: '..cityInformations.discord
  end,
  error = function(name)
    return '['..cityInformations.name..']\n\nOlá '..name..', não foi possível identificar sua Social Club.'
  end,
  kick = function(name)
    return '['..cityInformations.name..']\n\nOlá '..name..', você foi expulso da fila'
  end,
  desconnect = function(name)
    if not (name) then name = 'user' end;
    return '['..cityInformations.name..']\n\nOlá '..name..', você foi desconectado por demorar demais na fila.'
  end,
  position = function(name, yourPosition, size)
    return '['..cityInformations.name..']\n\nOlá '..name..', você é o '..yourPosition..'/'..size..' da fila, aguarde a sua conexão...\n\nAdquira prioridade na fila para logar mais rápido em nossa loja: '..cityInformations.shop
  end,
  finalMessage = function(langaguePos)
    return langaguePos..'\nEvite punições, fique por dentro das regras de conduta.\nAtualizações frequentes, deixe a sua sugestão em nosso discord.\n\nNosso discord: '..cityInformations.discord
  end
}