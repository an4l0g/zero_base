config = {}

config.groups = {
	['Staff'] = {
		information = {
			title = 'Zero Staff',
			groupType = 'staff',
			grades = {
				['Suporte'] = { title = 'Suporte', level = 1 },
				['Moderador'] = { title = 'Moderador', level = 2 },
				['Administrador'] = { title = 'Administrador', level = 3 },
				['Manager'] = { title = 'Manager', level = 4 },
				['COO'] = { title = 'COO', level = 5 },
				['CEO'] = { title = 'CEO', level = 6 }
			}
		},
		'staff.permissao',
		'polpar.permissao',
		'dv.permissao',
		'player.wall',
		'player.noclip'
	},

	['Vips'] = {
		information = {
			title = 'Vips',
			groupType = 'vips',
			grades = {
				['Bronze'] = { title = 'Bronze', level = 1 },
				['Prata'] = { title = 'Prata', level = 2 },
				['Ouro'] = { title = 'Ouro', level = 3 },
				['Rubi'] = { title = 'Rubi', level = 4 },
				['Ametista'] = { title = 'Ametista', level = 5 },
				['Safira'] = { title = 'Safira', level = 6 },
				['Diamante'] = { title = 'Diamante', level = 7 },
				['Zero'] = { title = 'Zero', level = 8 }
			}
		},
		'vip.permissao',
	},

	['VipArmas'] = {
		information = {
			title = 'Vip Armas',
		},
		'attachs2.permissao'
	},

	['Spotify'] = {
		information = {
			title = 'Spotify',
		},
		'spotify.permissao'
	},

	['Hospital'] = {
		information = { 
			title = 'Centro Médico', 
			groupType = 'job', 
			grades = {
				['Paramedico'] = { title = 'Paramédico', level = 1 },
				['Enfermeiro'] = { title = 'Enfermeiro', level = 2 },
				['Medico'] = { title = 'Médico', level = 3 },
				['Cirurgiao'] = { title = 'Cirurgião', level = 4 },
				['ViceDiretor'] = { title = 'Vice-Diretor', level = 5 },
				['Diretor'] = { title = 'Diretor', level = 6 },
			},
			grades_default = 'Paramedico',
		},
		'hospital.permissao',
		'polpar.permissao'
	},

	['ZeroFome'] = {
		information = { 
			title = 'Zero Fome', 
			groupType = 'job', 
			grades = {
				['Novato'] = { title = 'Novato', level = 1 },
				['Entregador'] = { title = 'Entregador', level = 2 },
				['Atendente'] = { title = 'Atendente', level = 3 },
				['Cozinheiro'] = { title = 'Cozinheiro', level = 4 },
				['Gerente'] = { title = 'Gerente', level = 5 },
				['Socio'] = { title = 'Sócio', level = 6 },
				['Dono'] = { title = 'Dono', level = 7 },
			},
			grades_default = 'Novato',
		},
		'zerofome.permissao'
	},
	
	['Holanda'] = {
		information = { 
			title = 'Holanda', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'holanda.permissao',
		'droga.permissao'
	},

	['Russia'] = {
		information = { 
			title = 'Rússia', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'russia.permissao',
		'droga.permissao'
	},

	['Cosanostra'] = {
		information = { 
			title = 'Cosanostra', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'cosanostra.permissao',
		'droga.permissao'
	},

	['Inglaterra'] = {
		information = { 
			title = 'Inglaterra', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'inglaterra.permissao',
		'droga.permissao'
	},

	['Tropa'] = {
		information = { 
			title = 'Tropa +5511', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'tropa.permissao',
		'lavagem.permissao'
	},

	['Helipa'] = {
		information = { 
			title = 'Helipa', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'helipa.permissao',
		'droga.permissao'
	},

	['Egito'] = {
		information = { 
			title = 'Egito', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'egito.permissao',
		'droga.permissao'
	},

	['Finish'] = {
		information = { 
			title = 'Finish', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'finish.permissao',
		'droga.permissao'
	},

	['Yakuza'] = {
		information = { 
			title = 'Yakuza', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'yakuza.permissao',
		'droga.permissao'
	},

	['Mafia'] = {
		information = { 
			title = 'Máfia', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'mafia.permissao',
		'lavagem.permissao'
	},

	['DuKaraio'] = {
		information = { 
			title = 'DuKaraio', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'dukaraio.permissao'
	},

	['Colombia'] = {
		information = { 
			title = 'Colômbia', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'colombia.permissao',
		'arma.permissao'
	},

	['Espanha'] = {
		information = { 
			title = 'Espanha', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'espanha.permissao',
		'arma.permissao'
	},

	['Canada'] = {
		information = { 
			title = 'Canadá', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'canada.permissao',
		'municao.permissao'
	},

	['Alemanha'] = {
		information = { 
			title = 'Alemanha', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'alemanha.permissao',
		'municao.permissao'
	},

	['ZeroMecanica'] = {
		information = { 
			title = 'Zero Mecanica', 
			groupType = 'fac', 
			grades = {
				['AuxMecanico'] = { title = 'Auxiliar de mecânico', level = 1 },
				['Mecanico'] = { title = 'Mecânico', level = 2 },
				['Funileiro'] = { title = 'Funileiro', level = 3 },
				['Gerente'] = { title = 'Gerente', level = 4 },
				['Supervisor'] = { title = 'Supervisor', level = 5 },
				['GerenteGeral'] = { title = 'Gerente Geral', level = 6 },
				['ViceLider'] = { title = 'Vice-Líder', level = 7 },
				['Lider'] = { title = 'Líder', level = 8 },
			},
			grades_default = 'Membro',
		},
		'mecanica.permissao',
		'mecanico.permissao',
		'zeromecanica.permissao'
	},

	['Policia'] = {
		information = { 
			title = 'Polícia', 
			groupType = 'job', 
			grades = {
				['Soldado'] = { title = 'Soldado', level = 1 },
				['Graduado'] = { title = 'Graduado', level = 2 },
				['Oficial'] = { title = 'Oficial', level = 3 },
				['AltoEscalao'] = { title = 'Alto Escalão', level = 4 },
				['SubComandante'] = { title = 'Sub-Comandante', level = 5 },
				['Comandante'] = { title = 'Comandante', level = 6 }
			},
			grades_default = 'Policia',
		},
		'policia.permissao',
		'polpar.permissao'
	},

	['Deic'] = {
		information = { 
			title = 'Deic', 
			groupType = 'job', 
			grades = {
				['Acadepol'] = { title = 'Acadepol', level = 1 },
				['Agente'] = { title = 'Agente', level = 2 },
				['Perito'] = { title = 'Perito', level = 3 },
				['Especialista'] = { title = 'Especialista', level = 4 },
				['Inspetor'] = { title = 'Inspetor', level = 5 },
				['Intendente'] = { title = 'Intendente', level = 6 },
				['Superintendente'] = { title = 'Superintendente', level = 7 },
				['Comissario'] = { title = 'Comissário', level = 8 },
				['Delegado'] = { title = 'Delegado', level = 9 },
				['Diretor'] = { title = 'Diretor Civil', level = 10 },
			},
			grades_default = 'Acadepol',
		},
		'deic.permissao',
		'policia.permissao',
		'polpar.permissao'
	},
}

Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')