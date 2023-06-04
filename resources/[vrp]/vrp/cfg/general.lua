cityName = 'ZERO ROLEPLAY'
cityDiscord = 'discord.gg/zerorp'
cityShop = 'https://zerorp.hydrus.gg/'

config = {
  maxPlayers = GetConvarInt('sv_maxclients'),
  maintenanceMode = false,
  priorityGroups = {
    ['Dono'] = 500,
    ['DonoOff'] = 500,
    ['Programador'] = 400,
    ['ProgramadorOff'] = 400,
    ['Priority100'] = 100,
    ['Priority75'] = 75,
    ['Priority50'] = 50,
    ['Priority25'] = 25,
    ['Priority10'] = 10,
  },
  maintenaneGroups = {
    ['Dono'] = true, 
    ['DonoOff'] = true,
    ['Diretor'] = true, 
    ['DiretorOff'] = true,
    ['Coordenador'] = true, 
    ['CoordenadorOff'] = true,
    ['Supervisor'] = true, 
    ['SupervisorOff'] = true,
    ['Programador'] = true,
    ['ProgramadorOff'] = true
  },
  language = {
    maintenance = function(name)
      return '['..cityName..']\n\nOlá '..name..', o servidor se encontra em manutenção nesse exato momento, volte mais tarde!\nMais informações em nosso discord: '..cityDiscord
    end,
    joining = function(name)
      return '['..cityName..']\n\nOlá '..name..', você está entrando na cidade...'
    end,
    connecting = function(name)
      return '['..cityName..']\n\nOlá '..name..', você está se conectando em nossa cidade...'
    end,
    connectingError = function(name)
      if not (name) then name = 'user' end;
      return '['..cityName..']\n\nOlá '..name..', não foi possível adicioná-lo na fila.\n\nNosso discord: '..cityDiscord
    end,
    error = function(name)
      return '['..cityName..']\n\nnOlá '..name..', não foi possível identificar sua Social Club.'
    end,
    kick = function(name)
      return '['..cityName..']\n\nnOlá '..name..', você foi expulso da fila'
    end,
    desconnect = function(name)
      if not (name) then name = 'user' end;
      return '['..cityName..']\n\nnOlá '..name..', você foi desconectado por demorar demais na fila.'
    end,
    position = function(name, yourPosition, size)
      return '['..cityName..']\n\nOlá '..name..', você é o '..yourPosition..'/'..size..' da fila, aguarde a sua conexão...\n\nAdquira prioridade na fila para logar mais rápido em nossa loja: '..cityShop
    end,
    finalMessage = function(langaguePos)
      return langaguePos..'\nEvite punições, fique por dentro das regras de conduta.\nAtualizações frequentes, deixe a sua sugestão em nosso discord.\n\nNosso discord: '..cityDiscord
    end
  },
  webhooks = {
    join = '',
    exit = '',
    weaponHack = ''
  },
  initMoney = {
    wallet = 5000,
    bank = 25000
  }
}