Tunnel = module('zero', 'lib/Tunnel')
Proxy = module('zero', 'lib/Proxy')
zero = Proxy.getInterface('zero')

radios = {
	-- STAFF
	{ name = 'Staff', permissions = { 'staff.permissao' } },
	{ name = 'Policia', permissions = { 'policia.permissao' } },
}