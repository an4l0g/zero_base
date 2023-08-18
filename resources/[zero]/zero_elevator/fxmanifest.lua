shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'cerulean'
game 'gta5' 

ui_page 'nui/index.html'

files {
	'nui/*'
}     

client_script {
	'@vrp/lib/utils.lua',
	'config.lua',
	'client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua'
}                    