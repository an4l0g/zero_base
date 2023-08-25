shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

author 'bluenzzz#0001 & an4log#0001'
description 'Zero Homes'
version '0.1'

ui_page 'nui/index.html'

client_scripts { 'client-side/*' }
server_scripts { 'server-side/*' }
shared_scripts { '@zero/lib/utils.lua', 'cfg/*.lua' }      

files { 'nui/*' }
