shared_script '@likizao_ac/client/library.lua'

fx_version "bodacious"
game "gta5"

-- ui_page "http://localhost:8502"
ui_page "http://104.234.189.131:8502"

client_script {
    "client/*.lua"
}

server_scripts {
    "server/*.lua"
}

shared_scripts {
    "@zero/lib/utils.lua",
    "configs/*.lua",
}
