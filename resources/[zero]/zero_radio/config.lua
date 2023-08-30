Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

radios = {
	-- STAFF
	{ name = 'Staff', permissions = { 'staff.permissao' } },
	{ name = 'Policia', permissions = { 'policia.permissao' } },
	{ name = 'CMZ', permissions = { 'hospital.permissao' } },
	{ name = 'CMZ Ronda', permissions = { 'hospital.permissao' } },

	-- FACS
	{ name = 'Rússia', permissions = { 'russia.permissao' } },
	{ name = 'Espanha', permissions = { 'espanha.permissao' } },
	{ name = 'Yakuza', permissions = { 'yakuza.permissao' } },
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
}