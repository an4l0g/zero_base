shared_script '@likizao_ac/client/library.lua'

fx_version 'cerulean'
game 'gta5'

ui_page 'nui/index.html'

client_scripts { 'client-side/*' }
server_scripts { 'server-side/*' }
shared_scripts { '@zero/lib/utils.lua', 'config.lua' }

files { 'nui/**/*' }