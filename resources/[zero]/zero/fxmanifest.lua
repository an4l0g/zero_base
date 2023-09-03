shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

ui_page 'nui/index.html'

loadscreen_manual_shutdown 'yes'
loadscreen 'loading/index.html'

client_script 'modules/client/*'
server_script 'modules/server/*'
shared_scripts { 'lib/utils.lua', 'zero.lua', 'cfg/*.lua' }

provide 'vrp'
files { 'lib/*.lua', 'nui/*', 'loading/*' }              