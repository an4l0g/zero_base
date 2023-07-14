fx_version 'bodacious'
game 'gta5'

ui_page 'http://localhost:5174/'

client_scripts { 'client/*.lua' }
server_scripts { 'server/*.lua' }
shared_scripts { '@zero/lib/utils.lua', 'main.lua', 'cfg/*.lua' }