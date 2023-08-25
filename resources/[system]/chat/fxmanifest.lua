shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

ui_page 'html/index.html'

client_scripts { 'cl_chat.lua' }
server_scripts { 'suggestions.lua', 'sv_chat.lua' }
shared_scripts { '@zero/lib/utils.lua', 'config.lua' }

files { 'html/**/**' }                                          