fx_version 'bodacious'
game 'gta5'

author 'bluenzzz & an4log'
description 'Zero Dynamic'
version '0.1'

ui_page "http://189.0.88.222:8504"
-- ui_page "http://localhost:5173"

client_script { 'client/*.lua' }
server_scripts { 'server/*.lua' }
shared_scripts { '@zero/lib/utils.lua', 'config.lua' }
