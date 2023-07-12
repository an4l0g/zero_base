config.lang = {
    ['Costureira'] = {
        ['startWorking'] = function(job)
            return 'Você iniciou um expediente!<br>Emprego: <b>'..job..'</b>'
        end,
        ['progressBar'] = 'Entregando a encomenda...',
        ['resetRoutes'] = 'Parabéns!<br>Você completou todas as rotas da nossa <b>empresa</b>, as suas rotas foram resetadas!',
        ['newRoute'] = 'Entrega feita com sucesso!<br>Uma nova rota foi detectada e adicionada em seu <b>GPS</b>.',
        ['backBusiness'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar mais encomendas'
        end,
        ['noVehicleBusiness'] = function(name)
            return 'Você não se encontra com o veículo da empresa <b>'..name..'</b>.'
        end,
        ['backBusinessVehicle'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar o veículo'
        end,
        ['stopWork'] = function(name)
            return 'Você finalizou o seu expediente!<br>A empresa <b>'..name..'</b> agradece pelos os seus serviços prestados.'
        end
    },
    ['Entregador'] = {
        ['startWorking'] = function(job)
            return 'Você iniciou um expediente!<br>Emprego: <b>'..job..'</b>'
        end,
        ['progressBar'] = 'Entregando a encomenda...',
        ['resetRoutes'] = 'Parabéns!<br>Você completou todas as rotas da nossa <b>empresa</b>, as suas rotas foram resetadas!',
        ['newRoute'] = 'Entrega feita com sucesso!<br>Uma nova rota foi detectada e adicionada em seu <b>GPS</b>.',
        ['backBusiness'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar mais encomendas'
        end,
        ['noVehicleBusiness'] = function(name)
            return 'Você não se encontra com o veículo da empresa <b>'..name..'</b>.'
        end,
        ['backBusinessVehicle'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar o veículo'
        end,
        ['stopWork'] = function(name)
            return 'Você finalizou o seu expediente!<br>A empresa <b>'..name..'</b> agradece pelos os seus serviços prestados.'
        end
    },
    ['Carteiro'] = {
        ['startWorking'] = function(job)
            return 'Você iniciou um expediente!<br>Emprego: <b>'..job..'</b>'
        end,
        ['progressBar'] = 'Entregando a encomenda...',
        ['resetRoutes'] = 'Parabéns!<br>Você completou todas as rotas da nossa <b>empresa</b>, as suas rotas foram resetadas!',
        ['newRoute'] = 'Entrega feita com sucesso!<br>Uma nova rota foi detectada e adicionada em seu <b>GPS</b>.',
        ['backBusiness'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar mais encomendas'
        end,
        ['noVehicleBusiness'] = function(name)
            return 'Você não se encontra com o veículo da empresa <b>'..name..'</b>.'
        end,
        ['backBusinessVehicle'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar o veículo'
        end,
        ['stopWork'] = function(name)
            return 'Você finalizou o seu expediente!<br>A empresa <b>'..name..'</b> agradece pelos os seus serviços prestados.'
        end
    },
    ['YellowJack'] = {
        ['startWorking'] = function(job)
            return 'Você iniciou um expediente!<br>Emprego: <b>'..job..'</b>'
        end,
        ['progressBar'] = 'Entregando a encomenda...',
        ['resetRoutes'] = 'Parabéns!<br>Você completou todas as rotas da nossa <b>empresa</b>, as suas rotas foram resetadas!',
        ['newRoute'] = 'Entrega feita com sucesso!<br>Uma nova rota foi detectada e adicionada em seu <b>GPS</b>.',
        ['backBusiness'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar mais encomendas'
        end,
        ['noVehicleBusiness'] = function(name)
            return 'Você não se encontra com o veículo da empresa <b>'..name..'</b>.'
        end,
        ['backBusinessVehicle'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar o veículo'
        end,
        ['stopWork'] = function(name)
            return 'Você finalizou o seu expediente!<br>A empresa <b>'..name..'</b> agradece pelos os seus serviços prestados.'
        end
    },
    ['Gas'] = {
        ['startWorking'] = function(job)
            return 'Você iniciou um expediente!<br>Emprego: <b>'..job..'</b>'
        end,
        ['progressBar'] = 'Trocando o gás...',
        ['resetRoutes'] = 'Parabéns!<br>Você completou todas as rotas da nossa <b>empresa</b>, as suas rotas foram resetadas!',
        ['newRoute'] = 'Troca feita com sucesso!<br>Uma nova rota foi detectada e adicionada em seu <b>GPS</b>.',
        ['backBusiness'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar mais gás'
        end,
        ['noVehicleBusiness'] = function(name)
            return 'Você não se encontra com o veículo da empresa <b>'..name..'</b>.'
        end,
        ['backBusinessVehicle'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar o veículo'
        end,
        ['stopWork'] = function(name)
            return 'Você finalizou o seu expediente!<br>A empresa <b>'..name..'</b> agradece pelos os seus serviços prestados.'
        end
    },
    ['Pedreiro'] = {
        ['startWorking'] = function(job)
            return 'Você iniciou um expediente!<br>Emprego: <b>'..job..'</b>'
        end,
        ['progressBar'] = 'Martelando...',
        ['resetRoutes'] = 'Parabéns!<br>Você completou todas as rotas da nossa <b>empresa</b>, as suas rotas foram resetadas!',
        ['newRoute'] = 'Conserto feito com sucesso!<br>Uma nova rota foi detectada e adicionada em seu <b>GPS</b>.',
        ['backBusiness'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar mais gás'
        end,
        ['noVehicleBusiness'] = function(name)
            return 'Você não se encontra com o veículo da empresa <b>'..name..'</b>.'
        end,
        ['backBusinessVehicle'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar o veículo'
        end,
        ['stopWork'] = function(name)
            return 'Você finalizou o seu expediente!<br>A empresa <b>'..name..'</b> agradece pelos os seus serviços prestados.'
        end
    },
    ['Eletricista'] = {
        ['startWorking'] = function(job)
            return 'Você iniciou um expediente!<br>Emprego: <b>'..job..'</b>'
        end,
        ['progressBar'] = 'Consertando...',
        ['resetRoutes'] = 'Parabéns!<br>Você completou todas as rotas da nossa <b>empresa</b>, as suas rotas foram resetadas!',
        ['newRoute'] = 'Conserto feito com sucesso!<br>Uma nova rota foi detectada e adicionada em seu <b>GPS</b>.',
        ['backBusiness'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar mais ferramentas'
        end,
        ['noVehicleBusiness'] = function(name)
            return 'Você não se encontra com o veículo da empresa <b>'..name..'</b>.'
        end,
        ['backBusinessVehicle'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar o veículo'
        end,
        ['stopWork'] = function(name)
            return 'Você finalizou o seu expediente!<br>A empresa <b>'..name..'</b> agradece pelos os seus serviços prestados.'
        end
    },
    ['Gari'] = {
        ['startWorking'] = function(job)
            return 'Você iniciou um expediente!<br>Emprego: <b>'..job..'</b>'
        end,
        ['progressBar'] = 'Varrendo...',
        ['resetRoutes'] = 'Parabéns!<br>Você completou todas as rotas da nossa <b>empresa</b>, as suas rotas foram resetadas!',
        ['newRoute'] = 'Limpeza feita com sucesso!<br>Uma nova rota foi detectada e adicionada em seu <b>GPS</b>.',
        ['backBusiness'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar mais ferramentas'
        end,
        ['noVehicleBusiness'] = function(name)
            return 'Você não se encontra com o veículo da empresa <b>'..name..'</b>.'
        end,
        ['backBusinessVehicle'] = function(name)
            return 'Retorne para a empresa <b>'..name..'</b> para pegar o veículo'
        end,
        ['stopWork'] = function(name)
            return 'Você finalizou o seu expediente!<br>A empresa <b>'..name..'</b> agradece pelos os seus serviços prestados.'
        end
    }
}