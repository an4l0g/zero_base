config = {}

config.types = {

    municao = {
        goals = { 
            { index = 'capsulas', name = 'Capsula' },
            { index = 'polvora', name = 'Pólvora' },
            { index = 'projetil', name = 'Projétil' },
        }, 
        products = {
            { 
                coastPerUnit = 50,
                index = 'm-rifle', 
                name = 'Muni. Type-97', 
                spawn = 'wammo|WEAPON_BULLPUPRIFLE_MK2', 
                materials = {
                    { index = 'capsulas', qtd = 4 },
                    { index = 'polvora', qtd = 8 },
                    { index = 'projetil', qtd = 6 },
                }
            },
            { 
                coastPerUnit = 50,
                index = 'm-rifle', 
                name = 'Muni. H&K G36C', 
                spawn = 'wammo|WEAPON_SPECIALCARBINE_MK2',
                materials = {
                    { index = 'capsulas', qtd = 1 },
                    { index = 'polvora', qtd = 4 },
                    { index = 'projetil', qtd = 2 },
                }
            },
            { 
                coastPerUnit = 50,
                index = 'm-smg', 
                name = 'Muni. Magpul PDR', 
                spawn = 'wammo|WEAPON_ASSAULTSMG',
                materials = {
                   { index = 'capsulas', qtd = 1 },
                    { index = 'polvora', qtd = 4 },
                    { index = 'projetil', qtd = 2 },
                }
            },
            { 
                coastPerUnit = 50,
               index = 'm-smg', 
                name = 'Muni. Sig Sauer MPX', 
                spawn = 'wammo|WEAPON_SMG_MK2',
                materials = {
                  { index = 'capsulas', qtd = 1 },
                    { index = 'polvora', qtd = 4 },
                    { index = 'projetil', qtd = 2 },
                }
            },
            { 
                coastPerUnit = 50,
                index = 'm-pistol', 
                name = 'Muni. FIVE SEVEN', 
                spawn = 'wammo|WEAPON_PISTOL_MK2',
                materials = {
                    { index = 'capsulas', qtd = 1 },
                    { index = 'polvora', qtd = 2 },
                    { index = 'projetil', qtd = 2 },
                }
            },
            { 
                coastPerUnit = 50,
                index = 'm-pistol', 
                name = 'Muni. TEC-9', 
                spawn = 'wammo|WEAPON_MACHINEPISTOL',
                materials = {
                    { index = 'capsulas', qtd = 1 },
                    { index = 'polvora', qtd = 5 },
                    { index = 'projetil', qtd = 2 },
                }
            },
        }
    },

    armas = {
        goals = { 
            { index = 'armacaodearma', name = 'Armação de Arma' },
            { index = 'mira', name = 'Mira de Arma' },
            { index = 'supressor', name = 'Supressor de Arma' },
            { index = 'pentedearma', name = 'Pente de Arma' },
        }, 
        products = {
            { 
                coastPerUnit = 4000,
                index = 'type-97', 
                name = 'Type-97', 
                spawn = 'wbody|WEAPON_BULLPUPRIFLE_MK2', 
                materials = {
                    { index = 'armacaodearma', qtd = 450 },
                    { index = 'mira', qtd = 1 },
                    { index = 'supressor', qtd = 1 },
                    { index = 'pentedearma', qtd = 1 },
                }
            },
            { 
                coastPerUnit = 4000,
                index = 'g36c', 
                name = 'H&K G36C', 
                spawn = 'wbody|WEAPON_SPECIALCARBINE_MK2', 
                materials = {
                    { index = 'armacaodearma', qtd = 250 },
                    { index = 'mira', qtd = 1 },
                    { index = 'supressor', qtd = 1 },
                    { index = 'pentedearma', qtd = 1 },
                }
            },
            { 
                coastPerUnit = 2500,
                index = 'magpul', 
                name = 'Magpul PDR', 
                spawn = 'wbody|WEAPON_ASSAULTSMG', 
                materials = {
                    { index = 'armacaodearma', qtd = 175 },
                    { index = 'mira', qtd = 1 },
                    { index = 'supressor', qtd = 1 },
                    { index = 'pentedearma', qtd = 1 },
                }
            },
            { 
                coastPerUnit = 2500,
                index = 'mpx', 
                name = 'Sig Sauer MPX', 
                spawn = 'wbody|WEAPON_SMG_MK2', 
                materials = {
                    { index = 'armacaodearma', qtd = 175 },
                    { index = 'mira', qtd = 1 },
                    { index = 'supressor', qtd = 1 },
                    { index = 'pentedearma', qtd = 1 },
                }
            },
            { 
                coastPerUnit = 2000,
                index = 'fiveseven', 
                name = 'FIVE SEVEN', 
                spawn = 'wbody|WEAPON_PISTOL_MK2', 
                materials = {
                    { index = 'armacaodearma', qtd = 150 },
                    { index = 'mira', qtd = 1 },
                    { index = 'supressor', qtd = 1 },
                    { index = 'pentedearma', qtd = 1 },
                }
            },
            { 
                coastPerUnit = 2000,
                index = 'tec9', 
                name = 'TEC-9', 
                spawn = 'wbody|WEAPON_MACHINEPISTOL', 
                materials = {
                    { index = 'armacaodearma', qtd = 230 },
                    { index = 'mira', qtd = 1 },
                    { index = 'supressor', qtd = 1 },
                    { index = 'pentedearma', qtd = 1 },
                }
            },
        }
    },

    lavagem = {
        goals = { 
            { index = 'notafiscal', name = 'Nota Fiscal' },
            { index = 'dinheirosujo', name = 'Dinheiro Sujo' },
        }, 
        products = {
            { 
                coastPerUnit = 0,
                index = 'malote-100000', 
                name = 'Malote de 100K', 
                spawn = 'malote-100000', 
                materials = {
                    { index = 'notafiscal', qtd = 10 },
                    { index = 'dinheirosujo', qtd = 110000 },
                }
            },
        }
    },

    contrabando = {
        goals = { 
            { index = 'pano', name = 'Pano' },
            { index = 'corda', name = 'Corda' },
            { index = 'barraferro', name = 'Barra de Ferro' },
            { index = 'pendrivedados', name = 'Pendrive com Dados' },
            { index = 'polvora', name = 'Pólvora' },
            { index = 'fitaadesiva', name = 'Fita Adesiva' },
            { index = 'fiosdecobre', name = 'Fios de Cobre' },
        }, 
        products = {
            { 
                coastPerUnit = 100,
                index = 'c4', 
                name = 'Bomba C4', 
                spawn = 'c4', 
                materials = {
                    { index = 'polvora', qtd = 10 },
                    { index = 'fitaadesiva', qtd = 10 },
                    { index = 'fiosdecobre', qtd = 10 },
                }
            },
            { 
                coastPerUnit = 100,
                index = 'capuz', 
                name = 'Capuz', 
                spawn = 'capuz', 
                materials = {
                    { index = 'pano', qtd = 10 },
                    { index = 'corda', qtd = 10 },
                }
            },
            { 
                coastPerUnit = 100,
                index = 'algemas', 
                name = 'Algemas', 
                spawn = 'algemas', 
                materials = {
                    { index = 'barraferro', qtd = 10 },
                }
            },
            { 
                coastPerUnit = 100,
                index = 'lockpick', 
                name = 'Lockpick', 
                spawn = 'lockpick', 
                materials = {
                    { index = 'barraferro', qtd = 10 },
                }
            },
            { 
                coastPerUnit = 100,
                index = 'masterpick', 
                name = 'Masterpick', 
                spawn = 'masterpick', 
                materials = {
                    { index = 'barraferro', qtd = 30 },
                }
            },
            { 
                coastPerUnit = 100,
                index = 'pendriveinvasao', 
                name = 'Pendrive para Invasão', 
                spawn = 'pendriveinvasao', 
                materials = {
                    { index = 'pendrivedados', qtd = 8 },
                }
            },
            { 
                coastPerUnit = 100,
                index = 'keycard', 
                name = 'Keycard Falsificado', 
                spawn = 'keycard', 
                materials = {
                    { index = 'pendrivedados', qtd = 4 },
                }
            },
            { 
                coastPerUnit = 100,
                index = 'cabra', 
                name = 'Pé de Cabra', 
                spawn = 'wbody|WEAPON_CROWBAR', 
                materials = {
                    { index = 'barraferro', qtd = 20 },
                }
            },
            { 
                coastPerUnit = 100,
                index = 'placa', 
                name = 'Placa', 
                spawn = 'placa', 
                materials = {
                    { index = 'pendrivedados', qtd = 1 },
                    { index = 'barraferro', qtd = 20 },
                    { index = 'fitaadesiva', qtd = 10 },
                }
            },
            { 
                coastPerUnit = 100,
                index = 'cordas', 
                name = 'Corda de Sequestro', 
                spawn = 'cordas', 
                materials = {
                    { index = 'corda', qtd = 10 }
                }
            },
        }
    },

    colete = {
        goals = { 
            { index = 'kevlar', name = 'Kevlar' },
            { index = 'tecido', name = 'Tecido' },
            { index = 'placametal', name = 'Placa de Metal' },
        }, 
        products = {
            { 
                coastPerUnit = 200,
                index = 'colete-contrabandiado', 
                name = 'Colete Contrabandiado', 
                spawn = 'colete-contrabandiado', 
                materials = {
                    { index = 'kevlar', qtd = 1 },
                    { index = 'tecido', qtd = 5 },
                    { index = 'placametal', qtd = 1 },
                }
            },
        }
    },

}

config.roles = {
    ilegal = { full_permissions = 'Lider', half_permissions = 'ViceLider' },
    policia = { full_permissions = { 'Navy', 'Comando' }, half_permissions = { 'SubComando', 'Capitao' }  },    
    hospital = { full_permissions = 'Diretor', half_permissions = 'Supervisor' },
    mecanica = { full_permissions = 'Chefe', half_permissions = 'Gerente' },
    creche = { full_permissions = 'Diretor', half_permissions = 'Coordenador' },
    judiciario = { full_permissions = 'Lider', half_permissions = 'PresidenteOAB' },
    gic = { full_permissions = 'Diretor', half_permissions = 'Delegado' },
    news = { full_permissions = 'Diretor', half_permissions = 'SecRedacao' },
}


config.grades = {
    ilegal = {
        'Lider',
        'ViceLider',
        'Membro'
    },
    policia = {
        'Navy',
        'Comando',     
        'SubComando',
        'Capitao',
        'Tenente',
        'Sargento',
        'Cabo',
        'Soldado',
    },
    hospital = {
        'Diretor',
        'Supervisor',
        'Medico',
        'Pediatra',
        'Paramedico',
        'Enfermeiro'
    },
    mecanica = {
        'Chefe',
        'Gerente',
        'Analista',
        'Mecanico',
        'Aprendiz',
    },
    creche = {
        'Diretor',
        'Coordenador',
        'Supervisor',
        'Professor',
        'Aluno',
    },
    judiciario = {
        'Lider',
        'PresidenteOAB',
        'Juiz',
        'Promotor',
        'Policial',
        'Advogado',
    },
    gic = {
        'Diretor',
        'Delegado',
        'Escrivao',
        'Perito',
        'Agente',
    },
    news = {
        'Diretor',
        'SecRedacao',
        'ChefeReportagem',
        'Jornalista',
        'Equipe',
    },
}

config.facs = {
    --==========================================================================
    ['Policia'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.policia,
        roles = config.roles.policia
    },
    ['GIC'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.gic,
        roles = config.roles.gic
    },
    ['Hospital'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.hospital,
        roles = config.roles.hospital
    },
    ['MecanicaBrazuca'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.mecanica,
        roles = config.roles.mecanica
    },
    ['Creche'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.creche,
        roles = config.roles.creche
    },
    ['Vanilla'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Judiciario'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.judiciario,
        roles = config.roles.judiciario
    },
    ['BrazucaNews'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.news,
        roles = config.roles.news
    },
   --[ DROGAS ]===============================================================
    ['Roxos'] = {
        vagas = 60,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Amarelos'] = {
        vagas = 40,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Azuis'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Verdes'] = {
        vagas = 70,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Vermelhos'] = {
        vagas = 100,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Rosas'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Cinzas'] = {
        vagas = 50,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Cianos'] = {
        vagas = 50,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    --[ ARMAS ]=================================================================
    ['Yakuza'] = {
        vagas = 30,
        serviceCheck = 'online',
        products = config.types.armas.goals,
        fabricationProducts = config.types.armas.products,
        storage = 1000,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Triade'] = {
        vagas = 50,
        serviceCheck = 'online',
        products = config.types.armas.goals,
        fabricationProducts = config.types.armas.products,
        storage = 1500,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Serpentes'] = {
        vagas = 10,
        serviceCheck = 'online',
        products = config.types.armas.goals,
        fabricationProducts = config.types.armas.products,
        storage = 500,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['CosaNostra'] = {
        vagas = 60,
        serviceCheck = 'online',
        products = config.types.armas.goals,
        fabricationProducts = config.types.armas.products,
        storage = 1500,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Sun'] = {
        vagas = 40,
        serviceCheck = 'online',
        products = config.types.armas.goals,
        fabricationProducts = config.types.armas.products,
        storage = 2500,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Complexo'] = {
        vagas = 30,
        serviceCheck = 'online',
        products = config.types.armas.goals,
        fabricationProducts = config.types.armas.products,
        storage = 5000,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    --[ MUNICAO ]===============================================================
    ['Vagos'] = {
        vagas = 30,
        serviceCheck = 'online',
        products = config.types.municao.goals,
        fabricationProducts = config.types.municao.products,
        storage = 1000,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Mafia'] = {
        vagas = 50,
        serviceCheck = 'online',
        products = config.types.municao.goals,
        fabricationProducts = config.types.municao.products,
        storage = 1000,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Bratva'] = {
        vagas = 70,
        serviceCheck = 'online',
        products = config.types.municao.goals,
        fabricationProducts = config.types.municao.products,
        storage = 2000,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Cartel'] = {
        vagas = 60,
        serviceCheck = 'online',
        products = config.types.municao.goals,
        fabricationProducts = config.types.municao.products,
        storage = 1000,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Diamond'] = {
        vagas = 30,
        serviceCheck = 'online',
        products = config.types.municao.goals,
        fabricationProducts = config.types.municao.products,
        storage = 500,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    --[ LAVAGEM ]===============================================================
    ['Tequilala'] = {
        vagas = 40,
        serviceCheck = 'online',
        products = config.types.lavagem.goals,
        fabricationProducts = config.types.lavagem.products,
        storage = 1000,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Bahamas'] = {
        vagas = 50,
        serviceCheck = 'online',
        products = config.types.lavagem.goals,
        fabricationProducts = config.types.lavagem.products,
        storage = 1000,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Galaxy'] = {
        vagas = 40,
        serviceCheck = 'online',
        products = config.types.lavagem.goals,
        fabricationProducts = config.types.lavagem.products,
        storage = 500,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    --[ CONTRABANDO ]===============================================================
    -- ['AngelsOfDeath'] = {
    --     vagas = 10,
    --     serviceCheck = 'online',
    --     products = config.types.contrabando.goals,
    --     fabricationProducts = config.types.contrabando.products,
    --     storage = 500,
    --     grades = config.grades.ilegal,
    --     roles = config.roles.ilegal
    -- },
    ['MotoClub'] = {
        vagas = 40,
        serviceCheck = 'online',
        products = config.types.contrabando.goals,
        fabricationProducts = config.types.contrabando.products,
        storage = 500,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['DriftKing'] = {
        vagas = 20,
        serviceCheck = 'online',
        products = config.types.contrabando.goals,
        fabricationProducts = config.types.contrabando.products,
        storage = 500,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['TokyoDrift'] = {
        vagas = 30,
        serviceCheck = 'online',
        products = config.types.contrabando.goals,
        fabricationProducts = config.types.contrabando.products,
        storage = 1000,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['SonsAnarchy'] = {
        vagas = 30,
        serviceCheck = 'online',
        products = config.types.contrabando.goals,
        fabricationProducts = config.types.contrabando.products,
        storage = 1000,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Ira'] = {
        vagas = 50,
        serviceCheck = 'online',
        products = config.types.contrabando.goals,
        fabricationProducts = config.types.contrabando.products,
        storage = 1000,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    --[ COLETE ]===============================================================
    ['Protec'] = {
        vagas = 30,
        serviceCheck = 'online',
        products = config.types.colete.goals,
        fabricationProducts = config.types.colete.products,
        storage = 500,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Alfa7'] = {
        vagas = 30,
        serviceCheck = 'online',
        products = config.types.colete.goals,
        fabricationProducts = config.types.colete.products,
        storage = 1500,
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
}