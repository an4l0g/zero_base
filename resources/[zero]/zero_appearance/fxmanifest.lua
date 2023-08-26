shared_script '@likizao_ac/client/library.lua'

fx_version 'bodacious'
game 'gta5'

author 'bluenzzz#0001 & an4log#0001'
description 'Zero Appearance'
version '0.1'

<<<<<<< HEAD
-- ui_page 'http://localhost:5173'
ui_page 'http://zerocity.gg:8509'
=======
ui_page 'http://localhost:5173'
-- ui_page 'http://189.0.88.222:8509'
>>>>>>> 0fe415fb0dd83422bab6a1d4f806e460c9b83191

client_scripts { 'client-side/main.lua', 'client-side/*.lua' }
server_scripts { 'server-side/main.lua', 'server-side/*.lua' }
shared_scripts { '@zero/lib/utils.lua', 'cfg/*.lua' }              
