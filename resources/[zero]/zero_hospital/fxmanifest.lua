shared_script '@likizao_ac/client/library.lua'

--shared_script "@vrp/lib/lib.lua" 
lua54 'yes'
fx_version "bodacious"
game "gta5"

ui_page "http://189.127.164.160:8507"
-- ui_page "http://localhost:5173"

client_script {
    "client/*.lua"
}

server_scripts {
    "server/*.lua"
}

shared_scripts {    
    "@zero/lib/utils.lua",
    "config.lua"
}
