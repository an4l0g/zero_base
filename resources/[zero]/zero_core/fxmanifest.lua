-- shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

ui_page 'ui/index.html'

client_scripts { 'client-side/**/*' }
server_scripts { 'server-side/**/*' }                                                        
shared_scripts { '@zero/lib/utils.lua', 'lib.lua', 'cfg/**.lua' }

files { 'ui/*' }