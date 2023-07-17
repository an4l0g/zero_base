fx_version 'bodacious'
game 'gta5'

author 'an4log'
description 'Zero Identity'
version '0.1'

ui_page "http://localhost:5173"

client_script 'client.lua'
server_script 'server.lua'
shared_scripts { '@zero/lib/utils.lua', 'config.lua' }              
