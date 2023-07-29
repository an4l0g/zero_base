local cityInformations = {
  name = 'ZERO ROLEPLAY',
  discord = 'discord.gg/zerorp',
  shop = 'https://zerorp.hydrus.gg/'
}

local config = {}

config.maxPlayers = GetConvarInt('sv_maxclients')

config.priorityGroups = {
  ['Dono'] = 500,
  ['Priority100'] = 100,
  ['Priority75'] = 75,
  ['Priority50'] = 50,
  ['Priority25'] = 25,
  ['Priority10'] = 10
}

config.maintenanceMode = false
config.maintenaneGroups = {
  ['Dono'] = true
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
      return '['..cityInformations.name..']\n\nnOlá '..name..', não foi possível identificar sua Social Club.'
    end,
    kick = function(name)
      return '['..cityInformations.name..']\n\nnOlá '..name..', você foi expulso da fila'
    end,
    desconnect = function(name)
      if not (name) then name = 'user' end;
      return '['..cityInformations.name..']\n\nnOlá '..name..', você foi desconectado por demorar demais na fila.'
    end,
    position = function(name, yourPosition, size)
      return '['..cityInformations.name..']\n\nOlá '..name..', você é o '..yourPosition..'/'..size..' da fila, aguarde a sua conexão...\n\nAdquira prioridade na fila para logar mais rápido em nossa loja: '..cityInformations.shop
    end,
    finalMessage = function(langaguePos)
      return langaguePos..'\nEvite punições, fique por dentro das regras de conduta.\nAtualizações frequentes, deixe a sua sugestão em nosso discord.\n\nNosso discord: '..cityInformations.discord
    end
}

config.webhooks = {
  join = 'https://discord.com/api/webhooks/1134350140300329090/5o-86yZHgDcpx2URSaDuDBJDMoXThNYz-ajQCxMq1N_1jLGJUVIvCKstWcVfaGMcqmJu',
  exit = 'https://discord.com/api/webhooks/1134350166678323272/AqsznuKDjohWNvnLTOR_PIWJ13nMhqM6CMD8MaSfhAi0ilS6M61rnBoxBMZkuNXICnYd',
  bugSource = 'https://discord.com/api/webhooks/1134546955457003520/f8lfFRci2fr2IwgDc9QmlPE2ASA_MBo6OW0a_EJ8nedWoxwGk9v4AFYiCaIky9uUuwrh',
  weaponHack = '',
  antiflood = 'https://discord.com/api/webhooks/1122335314397122671/gCJlPjrzaz8UhZ39UTbxKkZJz1FAKVJYNjW_zWI4rk1B1dtHUDX_ARHZpe8qweqE4LOI'
}

return config