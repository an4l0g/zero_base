shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

author 'bluenzzz#0001'
description 'Zero Notify Push'
version '0.1'

ui_page 'nui/index.html'

client_script 'client.lua'
server_script 'server.lua'
shared_scripts { '@zero/lib/utils.lua', 'shared.lua' }

files { 'nui/*' }