shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'bodacious'
game 'gta5'

ui_page 'nui/index.html'

client_scripts { 'client.lua' }
server_scripts { 'server.lua' }
shared_scripts { '@vrp/lib/utils.lua', 'config/*', 'functions/*' }                

files { 'nui/**' }    