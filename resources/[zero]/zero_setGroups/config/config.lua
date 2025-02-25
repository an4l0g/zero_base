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

	['Porte'] = {
		information = {
			title = 'Porte de Arma',
		},
		'porte.permissao'
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

	['Instagram'] = {
		information = {
			title = 'Verificado',
		},
		'instagram.permissao'
	},

	['Cam'] = {
		information = {
			title = 'Cam',
		},
		'cam.permissao'
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
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'holanda.permissao',
		'arma.permissao',
		'ilegal.permissao'
	},

	['Polonia'] = {
		information = { 
			title = 'Polônia', 
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'polonia.permissao',
		'droga.permissao',
		'ilegal.permissao'
	},

	['Russia'] = {
		information = { 
			title = 'Rússia', 
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'russia.permissao',
		'municao.permissao'
		'ilegal.permissao'
	},

	['Cosanostra'] = {
		information = { 
			title = 'Cosanostra', 
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'cosanostra.permissao',
		'droga.permissao',
		'ilegal.permissao'
	},

	['Inglaterra'] = {
		information = { 
			title = 'Inglaterra', 
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'inglaterra.permissao',
		'droga.permissao',
		'ilegal.permissao'
	},

	['Tropa'] = {
		information = { 
			title = 'Bélgica', 
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'tropa.permissao',
		'droga.permissao'
		'ilegal.permissao'
	},

	['Helipa'] = {
		information = { 
			title = 'Helipa', 
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'helipa.permissao',
		'arma.permissao',
		'ilegal.permissao'
	},


	['Finish'] = {
		information = { 
			title = 'Finish', 
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'finish.permissao',
		'droga.permissao',
		'ilegal.permissao'
	},

	['Camorra'] = {
		information = { 
			title = 'Braznx', 
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'camorra.permissao',
		'lavagem.permissao',
		'ilegal.permissao'
	},

	['Colombia'] = {
		information = { 
			title = 'Colômbia', 
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'colombia.permissao',
		'arma.permissao',
		'ilegal.permissao'
	},

	['Espanha'] = {
		information = { 
			title = 'Espanha', 
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'espanha.permissao',
		'arma.permissao',
		'ilegal.permissao'
	},

	['Canada'] = {
		information = { 
			title = 'Canadá', 
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'canada.permissao',
		'municao.permissao',
		'ilegal.permissao'
	},

	['Alemanha'] = {
		information = { 
			title = 'Alemanha', 
			groupType = 'job', 
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'alemanha.permissao',
		'municao.permissao',
		'ilegal.permissao'
	},

	['ZeroMecanica'] = {
		information = { 
			title = 'Zero Mecanica', 
			groupType = 'job', 
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
		'zeromecanica.permissao',
		'ilegal.permissao'
	},

	['Juridico'] = {
		information = { 
			title = 'Jurídico', 
			groupType = 'job', 
			grades = {
				['Estagiario'] = { title = 'Estagiário', level = 1 },
				['Seguranca'] = { title = 'Segurança', level = 2 },
				['ChefeSeguranca'] = { title = 'Chefe da Segurança', level = 3 },
				['AdvogadoJunior'] = { title = 'Advogado Jr', level = 4 },
				['AdvogadoPleno'] = { title = 'Advogado Pleno', level = 5 },
				['AdvogadoSenior'] = { title = 'Advogado Senior', level = 6 },
				['SecretarioAdjunto'] = { title = 'Secretário Adjunto', level = 7 },
				['SecretarioGeral'] = { title = 'Secretário Geral', level = 8 },
				['VicePresidente'] = { title = 'Vice-Presidente', level = 9 },
				['Presidente'] = { title = 'Presidente', level = 10 },
			},
			grades_default = 'Estagiario',
		},
		'juridico.permissao'
	},

	['VipPolicia'] = {
		information = { 
			title = 'VIP Polícia', 
		},
		'attachs2.permissao',
		'vippm.permissao'
	},

	['Policia'] = {
		information = { 
			title = 'Polícia', 
			groupType = 'job', 
			grades = {
				-- ['Soldado'] = { title = 'Soldado', level = 1 },
				-- ['Graduado'] = { title = 'Graduado', level = 2 },
				-- ['Oficial'] = { title = 'Oficial', level = 3 },
				-- ['AltoEscalao'] = { title = 'Alto Escalão', level = 4 },
				-- ['SubComandante'] = { title = 'Sub-Comandante', level = 5 },
				-- ['Comandante'] = { title = 'Comandante', level = 6 }

				['SoldadoEV'] = { title = 'Soldado E.V', level = 1 },
				['SoldadoEP'] = { title = 'Soldado E.P', level = 2 },

				['Cabo'] = { title = 'Cabo', level = 4 },
				['Sargento3'] = { title = '3° Sargento', level = 3 },
				['Sargento2'] = { title = '2° Sargento', level = 4 },
				['Sargento1'] = { title = '1° Sargento', level = 5 },
				['SubTenente'] = { title = 'Subtenente', level = 6 },

				['Aspirante'] = { title = 'Aspirante a Oficial', level = 7 },
				['Tenente2'] = { title = '2° Tenente', level = 8 },
				['Tenente1'] = { title = '1° Tenente', level = 9 },

				['Capitao'] = { title = 'Capitão', level = 10 },
				['Major'] = { title = 'Major', level = 11 },
				['TenenteCoronel'] = { title = 'Tenente-Coronel', level = 12 },
				['Coronel'] = { title = 'Coronel', level = 13 },
				['General'] = { title = 'General', level = 14 },
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