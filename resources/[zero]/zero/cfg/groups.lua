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

	['Hospital'] = {
		information = { 
			title = 'Centro Médico', 
			groupType = 'job', 
			grades = {
				['Paramedico'] = { title = '[Hospital] Paramédico', level = 1 },
				['Enfermeiro'] = { title = '[Hospital] Enfermeiro', level = 2 },
				['Medico'] = { title = '[Hospital] Médico', level = 3 },
				['Cirurgiao'] = { title = '[Hospital] Cirurgião', level = 4 },
				['ViceDiretor'] = { title = '[Hospital] Médico', level = 5 },
				['Diretor'] = { title = '[Hospital] Diretor', level = 6 },
			},
			grades_default = 'Paramedico',
		},
		'hospital.permissao'
	},

	['ZeroFome'] = {
		information = { 
			title = 'Zero Fome', 
			groupType = 'job', 
			grades = {
				['Novato'] = { title = '[Zero Fome] Novato', level = 1 },
				['Entregador'] = { title = '[Zero Fome] Entregador', level = 2 },
				['Atendente'] = { title = '[Zero Fome] Atendente', level = 3 },
				['Cozinheiro'] = { title = '[Zero Fome] Cozinheiro', level = 4 },
				['Gerente'] = { title = '[Zero Fome] Gerente', level = 5 },
				['Socio'] = { title = '[Zero Fome] Sócio', level = 6 },
				['Dono'] = { title = '[Zero Fome] Dono', level = 7 },
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
				['Membro'] = { title = '[Holanda] Membro', level = 1 },
				['Gerente'] = { title = '[Holanda] Gerente', level = 2 },
				['ViceLider'] = { title = '[Holanda] Vice-Líder', level = 3 },
				['Lider'] = { title = '[Holanda] Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'holanda.permissao'
	},

	['Egito'] = {
		information = { 
			title = 'Egito', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = '[Egito] Membro', level = 1 },
				['Gerente'] = { title = '[Egito] Gerente', level = 2 },
				['ViceLider'] = { title = '[Egito] Vice-Líder', level = 3 },
				['Lider'] = { title = '[Egito] Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'egito.permissao'
	},

	['Finish'] = {
		information = { 
			title = 'Finish', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = '[Finish] Membro', level = 1 },
				['Gerente'] = { title = '[Finish] Gerente', level = 2 },
				['ViceLider'] = { title = '[Finish] Vice-Líder', level = 3 },
				['Lider'] = { title = '[Finish] Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'finish.permissao'
	},

	['PCC'] = {
		information = { 
			title = 'PCC', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = '[PCC] Membro', level = 1 },
				['Gerente'] = { title = '[PCC] Gerente', level = 2 },
				['ViceLider'] = { title = '[PCC] Vice-Líder', level = 3 },
				['Lider'] = { title = '[PCC] Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'pcc.permissao'
	},

	['LosZeta'] = {
		information = { 
			title = 'Los Zeta', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = '[Los Zeta] Membro', level = 1 },
				['Gerente'] = { title = '[Los Zeta] Gerente', level = 2 },
				['ViceLider'] = { title = '[Los Zeta] Vice-Líder', level = 3 },
				['Lider'] = { title = '[Los Zeta] Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'loszeta.permissao'
	},

	['Mafia'] = {
		information = { 
			title = 'Mafia', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = '[Mafia] Membro', level = 1 },
				['Gerente'] = { title = '[Mafia] Gerente', level = 2 },
				['ViceLider'] = { title = '[Mafia] Vice-Líder', level = 3 },
				['Lider'] = { title = '[Mafia] Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'mafia.permissao'
	},

	['DuKaraio'] = {
		information = { 
			title = 'DuKaraio', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = '[DuKaraio] Membro', level = 1 },
				['Gerente'] = { title = '[DuKaraio] Gerente', level = 2 },
				['ViceLider'] = { title = '[DuKaraio] Vice-Líder', level = 3 },
				['Lider'] = { title = '[DuKaraio] Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'dukaraio.permissao'
	},

	['Colombia'] = {
		information = { 
			title = 'Colombia', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = '[Colombia] Membro', level = 1 },
				['Gerente'] = { title = '[Colombia] Gerente', level = 2 },
				['ViceLider'] = { title = '[Colombia] Vice-Líder', level = 3 },
				['Lider'] = { title = '[Colombia] Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'colombia.permissao'
	},

	['Espanha'] = {
		information = { 
			title = 'Espanha', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = '[Espanha] Membro', level = 1 },
				['Gerente'] = { title = '[Espanha] Gerente', level = 2 },
				['ViceLider'] = { title = '[Espanha] Vice-Líder', level = 3 },
				['Lider'] = { title = '[Espanha] Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'espanha.permissao'
	},

	['Canada'] = {
		information = { 
			title = 'Canada', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = '[Canada] Membro', level = 1 },
				['Gerente'] = { title = '[Canada] Gerente', level = 2 },
				['ViceLider'] = { title = '[Canada] Vice-Líder', level = 3 },
				['Lider'] = { title = '[Canada] Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'canada.permissao'
	},

	['Alemanha'] = {
		information = { 
			title = 'Alemanha', 
			groupType = 'fac', 
			grades = {
				['Membro'] = { title = '[Alemanha] Membro', level = 1 },
				['Gerente'] = { title = '[Alemanha] Gerente', level = 2 },
				['ViceLider'] = { title = '[Alemanha] Vice-Líder', level = 3 },
				['Lider'] = { title = '[Alemanha] Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'alemanha.permissao'
	},

	['ZeroMecanica'] = {
		information = { 
			title = 'Zero Mecanica', 
			groupType = 'fac', 
			grades = {
				['AuxMecanico'] = { title = '[Mecânica] Auxiliar de mecânico', level = 1 },
				['Mecanico'] = { title = '[Mecânica] Mecânico', level = 2 },
				['Funileiro'] = { title = '[Mecânica] Funileiro', level = 3 },
				['Gerente'] = { title = '[Mecânica] Gerente', level = 4 },
				['Supervisor'] = { title = '[Mecânica] Supervisor', level = 5 },
				['GerenteGeral'] = { title = '[Mecânica] Gerente Geral', level = 6 },
				['ViceLider'] = { title = '[Mecânica] Vice-Líder', level = 7 },
				['Lider'] = { title = '[Mecânica] Líder', level = 8 },
			},
			grades_default = 'Membro',
		},
		'zeromecanica.permissao'
	},
}

config.users = {
	[1] = { ['Staff'] = 'CEO' },
	[2] = { ['Staff'] = 'CEO' }
}