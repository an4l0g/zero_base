fx_version 'cerulean'
game 'gta5' 

ui_page 'nui/index.html'

files {
	'nui/*'
}     

client_script {
	'@zero/lib/utils.lua',
	'config.lua',
	'client.lua'
}

server_scripts {
	'@zero/lib/utils.lua',
	'server.lua'
}                    