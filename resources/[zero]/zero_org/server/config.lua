config = {}

config.roles = {
    ilegal = { full_permissions = {'Lider', 'ViceLider'}, half_permissions = 'Gerente' },
    policia = { full_permissions = { 'Comandante' }, half_permissions = { 'SubComandante' }  },    
    deic = { full_permissions = { 'Diretor' }, half_permissions = { 'Diretor' }  },    
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
    deic = {
        'Diretor',
        'Delegado',
        'Comissario',
        'Superintendente',
        'Intendente',
        'Inspetor',
        'Especialista',
        'Perito',
        'Agente',
        'Acadepol'
    },
    policia = {
        'Comandante',
        'SubComandante',
        'AltoEscalao',
        'Oficial',
        'Graduado',
        'Soldado'
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
    ['Deic'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.deic,
        roles = config.roles.deic
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
        grades = config.grades.mecanica,
        roles = config.roles.mecanica
    },
    ['Russia'] = {
        vagas = 36,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
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
        vagas = 50,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Tropa'] = {
        vagas = 25,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Inglaterra'] = {
        vagas = 25,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Espanha'] = {
        vagas = 50,
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
    ['Helipa'] = {
        vagas = 40,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Yakuza'] = {
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

    ['Cosanostra'] = {
        vagas = 20,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
}