shared_script "@vrp/lib/lib.lua" 
lua54 'yes'
fx_version "bodacious"
game "gta5"

ui_page "http://localhost:8502"
-- ui_page "http://localhost:5173"

client_script {
    "crosscript/client.lua",
    "client/*.lua"
}

server_scripts {
    "crosscript/server.lua",
    "server/*.lua"
}

shared_scripts {
    "@vrp/lib/utils.lua",
    "configs/*.lua",
    "crosscript/_queue.lua",
}
