shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

author 'bluenzzz#0001 & an4log#0001'
description 'Zero Appearance'
version '0.1'

ui_page 'http://nui-zero-appearance.vercel.app/'

client_scripts { 'client-side/main.lua', 'client-side/*.lua' }
server_scripts { 'server-side/main.lua', 'server-side/*.lua' }
shared_scripts { '@zero/lib/utils.lua', 'cfg/*.lua' }              
