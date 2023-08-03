fx_version 'bodacious'
game 'gta5'

author 'bluenzzz#0001 & an4log#0001'
description 'Zero Shop'
version '0.1'

ui_page 'ui/index.html'

client_script 'client.lua'
server_script 'server.lua'                                   
shared_scripts { '@zero/lib/utils.lua', 'config.lua' }

files { 'ui/*' }