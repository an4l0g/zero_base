groupConfig = {}
-- PERMISSÃO DEFAULT DA STAFF SERÁ staff.permissao
groupConfig.groups = {
	['Dono'] = {
		information = {
			title = 'Dono',
			groupType = 'staff'
		},
		'dono.permissao',
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

groupConfig.users = {
	[1] = { 'Dono' },
	[158] = { 'Dono' }
}