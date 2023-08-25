shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

author 'bluenzzz & an4log'
description 'Zero Fuel'
version '0.1'

ui_page 'web/index.html'

client_script 'client.lua'
server_script 'server.lua'                                   
shared_scripts { '@zero/lib/utils.lua', 'config.lua' }

files { 'web/**/*' }