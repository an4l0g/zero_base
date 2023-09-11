shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

author 'an4log'
description 'Zero Production'
version '0.1'

ui_page "http://189.127.164.160:8506"
-- ui_page "http://189.127.164.160:5173"

client_script 'client.lua'
server_script 'server.lua'
shared_scripts { '@zero/lib/utils.lua', 'config.lua' }              
