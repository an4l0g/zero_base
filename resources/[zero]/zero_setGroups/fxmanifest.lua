shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'bodacious'
game 'gta5'

dependency 'vrp'

client_scripts {
	'@vrp/lib/utils.lua',
	'client/client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server/server.lua'
}

ui_page'html/index.html'

files {
    'html/index.html',
    'html/scripts.js',
    'html/styles.css',
}                            