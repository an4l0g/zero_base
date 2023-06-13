lua54 'yes'
fx_version "bodacious"
game "gta5"

-- ui_page "http://localhost:8501"
ui_page "http://localhost:5173"

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
