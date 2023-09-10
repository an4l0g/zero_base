shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

author 'bluenzzz#0001 & an4log#0001'
description 'Zero Character'
version '0.1'

-- ui_page "http://localhost:5173"
ui_page "http://189.127.164.160:8503"

client_scripts { 'client/*.lua' }
server_scripts { 'server/*.lua' }
shared_scripts { '@zero/lib/utils.lua', 'cfg/main.lua', 'cfg/*.lua' }              
