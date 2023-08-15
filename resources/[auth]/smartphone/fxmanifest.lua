fx_version 'adamant'
game 'gta5'

client_scripts { 'client.lua', 'static-client.lua' }
server_scripts { 'server.js', 'server.lua' }
shared_scripts { '@zero/lib/utils.lua' }



ui_page 'index.html'

files {
  'index.html',
  'html/*',
  'images/*'
}