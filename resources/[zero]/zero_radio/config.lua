Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

radios = {
	-- Polícia
	{ name = 'Patrulha', permissions = { 'policia.permissao' } },
	{ name = 'Policia 1', permissions = { 'policia.permissao' } },
	{ name = 'Policia 2', permissions = { 'policia.permissao' } },
	{ name = 'Policia 3', permissions = { 'policia.permissao' } },
	{ name = 'Ação 1', permissions = { 'policia.permissao' } },
	{ name = 'Ação 2', permissions = { 'policia.permissao' } },
	{ name = 'Ação 3', permissions = { 'policia.permissao' } },

	-- STAFF
	{ name = 'Staff', permissions = { 'staff.permissao' } },
	{ name = 'CMZ', permissions = { 'hospital.permissao' } },
	{ name = 'CMZ Ronda', permissions = { 'hospital.permissao' } },

	-- FACS
	{ name = 'Rússia', permissions = { 'russia.permissao' } },
	{ name = 'Espanha', permissions = { 'espanha.permissao' } },
	{ name = 'Camorra', permissions = { 'camorra.permissao' } },
	{ name = 'Cosanostra', permissions = { 'cosanostra.permissao' } },
	{ name = 'Finish', permissions = { 'finish.permissao' } },
	{ name = 'Colômbia', permissions = { 'colombia.permissao' } },
	{ name = 'Canadá', permissions = { 'canada.permissao' } },
	{ name = 'Tropa +5511', permissions = { 'tropa.permissao' } },
	{ name = 'Inglaterra', permissions = { 'inglaterra.permissao' } },
	{ name = 'Máfia', permissions = { 'mafia.permissao' } },
	{ name = 'Alemanha', permissions = { 'alemanha.permissao' } },
	{ name = 'Holanda', permissions = { 'holanda.permissao' } },
	{ name = 'Helipa', permissions = { 'helipa.permissao' } },
	{ name = 'Egito', permissions = { 'egito.permissao' } },
	{ name = 'Polonia', permissions = { 'polonia.permissao' } },
}