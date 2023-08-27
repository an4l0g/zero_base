shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

author 'bluenzzz & an4log'
description 'Zero Identity'
version '0.1'

ui_page "http://104.234.189.131:8508/"

client_script 'client-side/*.lua'
server_script 'server-side/*.lua'
shared_scripts { '@zero/lib/utils.lua', 'config.lua' }              
