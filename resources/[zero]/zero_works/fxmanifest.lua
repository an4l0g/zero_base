shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

author 'bluenzzz#0001 & an4log'
description 'Zero Works'
version '0.1'

ui_page 'nui/index.html'

client_scripts { 'client.lua' }
server_scripts { 'server.lua' }
shared_scripts { '@zero/lib/utils.lua', 'config/*', 'functions/*' }                

files { 'nui/**' }    