shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

ui_page'html/index.html'

client_script 'client/*'
server_script 'server/*'
shared_scripts { '@zero/lib/utils.lua', 'config/*' }

files { 'html/*' }                            