fx_version 'bodacious'
game 'gta5'

ui_page 'ui/index.html'

client_scripts { 'client-side/**/*' }
server_scripts { 'server-side/**/*' }                                                        
shared_scripts { '@zero/lib/utils.lua', 'cfg/**.lua', 'main.lua' }

files { 'ui/*' }