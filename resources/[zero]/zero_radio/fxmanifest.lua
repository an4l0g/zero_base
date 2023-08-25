shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5' 

ui_page 'nui/ui.html'

client_script 'client.lua'
server_script 'server.lua'
shared_scripts { '@zero/lib/utils.lua', 'config.lua' }
files { 'nui/*' }              