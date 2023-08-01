fx_version 'bodacious'
game 'gta5'

ui_page 'ui/index.html'

client_scripts { 'client-side/**/*' }
server_scripts { 'server-side/**/*' }                                                        
<<<<<<< HEAD
shared_scripts { '@zero/lib/utils.lua', 'cfg/**.lua', 'main.lua' }
=======
shared_scripts { '@zero/lib/utils.lua', 'lib.lua', 'cfg/**.lua' }
>>>>>>> 5fb6f0ed8283d344abca6a8db86ecf8fc9c99b7d

files { 'ui/*' }