shared_script "@zero/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'bodacious'
game 'gta5'

dependency 'zero'

client_scripts {
	'@zero/lib/utils.lua',
	'client/client.lua'
}

server_scripts {
	'@zero/lib/utils.lua',
	'server/server.lua'
}

ui_page'html/index.html'

files {
    'html/index.html',
    'html/scripts.js',
    'html/styles.css',
}                            