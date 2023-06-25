fx_version 'bodacious'
game 'gta5'

ui_page 'ui/index.html'

client_script 'client.lua'
server_script 'server.lua'                                   
shared_scripts { '@zero/lib/utils.lua', 'config.lua' }

files { 'ui/*' }