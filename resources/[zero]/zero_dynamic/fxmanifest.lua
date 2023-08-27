shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

author 'bluenzzz & an4log'
description 'Zero Dynamic'
version '0.1'

ui_page 'http://104.234.189.131:8504/'
-- ui_page 'http://localhost:5173/'

client_scripts { 'client/*.lua' }
server_scripts { 'server/*.lua' }
shared_scripts { '@zero/lib/utils.lua', 'cfg/*.lua' }
