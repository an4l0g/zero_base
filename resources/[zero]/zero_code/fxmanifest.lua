shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

ui_page 'web-side/index.html'

client_script 'client.lua'
server_script 'server.lua'
shared_scripts { '@vrp/lib/utils.lua', 'main.lua' }

files { 'web-side/**/**/*' }