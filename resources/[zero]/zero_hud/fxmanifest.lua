fx_version "bodacious"
game "gta5"

ui_page "http://zerocity.gg:8501"

client_script {
    "client/*.lua"
}

server_scripts {
    "server/*.lua"
}

shared_scripts {
    "@zero/lib/utils.lua",
}
