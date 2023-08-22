fx_version 'adamant'
game 'gta5'
lua54 'yes'
version '1.0.0'

author 'an4log#0001'

ui_page 'nui/index.html'

files {
	'nui/**/*'
}

client_scripts {
	'crosscript/client.lua',
	'client/*.lua',
}

shared_scripts { "@zero/lib/utils.lua", "configs/*.lua", "crosscript/_queue.lua" }

server_scripts {
	'crosscript/server.lua',
	'server/*.lua',
}

escrow_ignore { '/configs/*.lua', 'nui/*' }

dependency '/assetpacks'
dependency '/assetpacks'