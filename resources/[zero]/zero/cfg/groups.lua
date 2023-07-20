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
		'dv.permissao'
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
	}
}

config.users = {
	[1] = { ['Staff'] = 'CEO' },
	[2] = { ['Staff'] = 'CEO' }
}

return config