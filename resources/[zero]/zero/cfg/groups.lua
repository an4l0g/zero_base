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
	}
}

config.users = {
	[1] = { 'Dono' },
	[2] = { 'Dono' }
}

return config