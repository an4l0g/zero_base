-- PERMISSÃO DEFAULT DA STAFF SERÁ staff.permissao
config = {}

config.groups = {
	['Dono'] = {
		information = {
			title = 'Dono',
			groupType = 'staff'
		},
		'dono.permissao',
		'manager.permissao',
		'diretor.permissao',
		'coordenador.permissao',
		'admin.permissao',
		'mod.permissao',
		'suporte.permissao',
		'staff.permissao',
		'polpar.permissao',
		'dv.permissao'
	},

	['Developer'] = {
		information = { title = 'Desenvolvedor', groupType = 'staff' },
		'staff.permissao' 
	},

	['Hospital'] = {
		information = { 
			title = 'Centro Médico', 
			groupType = 'hospital', 
			grades = {
				['Diretor'] = { title = 'Médico', level = 2 },
				['ViceDiretor'] = { title = 'Médico', level = 2 },
				['Cirurgiao'] = { title = 'Cirurgião', level = 2 },
				['Medico'] = { title = 'Médico', level = 2 },
				['Enfermeiro'] = { title = 'Enfermeiro', level = 2 },
				['Paramedico'] = { title = 'Paramédico', level = 1 },
			},
			grades_default = 'Paramedico',
		},
	'hospital.permissao'
	}
}

config.users = {
	[1] = { 'Dono' },
	[2] = { 'Dono' }
}

return config