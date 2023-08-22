config = {}

config.roles = {
    ilegal = { full_permissions = {'Lider', 'ViceLider'}, half_permissions = 'Gerente' },
    policia = { full_permissions = { 'Navy', 'Comando' }, half_permissions = { 'SubComando', 'Capitao' }  },    
    hospital = { full_permissions = 'Diretor', half_permissions = 'Supervisor' },
    mecanica = { full_permissions = { 'Lider', 'ViceLider' }, half_permissions = 'Gerente' },
    restaurante = { full_permissions = { 'Dono', 'Socio' }, half_permissions = 'Gerente' },
    judiciario = { full_permissions = 'Lider', half_permissions = 'PresidenteOAB' },
}


config.grades = {
    ilegal = {
        'Lider',
        'ViceLider',
        'Gerente',
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
        'Lider',
        'ViceLider',
        'Gerente',
        'Supervisor',
        'Funileiro',
        'Mecanico',
        'AuxMecanico',
    },
    restaurante  = {
        'Dono',
        'Socio',
        'Gerente',
        'Cozinheiro',
        'Atendente',
        'Entregador',
        'Novato',
    },
    judiciario = {
        'Lider',
        'PresidenteOAB',
        'Juiz',
        'Promotor',
        'Policial',
        'Advogado',
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
    ['Hospital'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.hospital,
        roles = config.roles.hospital
    },
    ['ZeroFome'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.restaurante,
        roles = config.roles.restaurante
    },
    ['ZeroMecanica'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.hospital,
        roles = config.roles.hospital
    },
    ['Alemanha'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Canada'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Colombia'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['DuKaraio'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Egito'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Espanha'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Finish'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Holanda'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['LosZeta'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Mafia'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['PCC'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['PCC'] = {
        vagas = 30,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
}