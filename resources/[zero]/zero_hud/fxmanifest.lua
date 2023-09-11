shared_script '@likizao_ac/client/library.lua'

fx_version "bodacious"
game "gta5"

ui_page "http://189.127.164.160:8501"

client_script {
    "client/*.lua"
}

server_scripts {
    "server/*.lua"
}

shared_scripts {
    "@zero/lib/utils.lua",
}
