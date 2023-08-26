shared_script '@likizao_ac/client/library.lua'

fx_version "bodacious"
game "gta5"

-- ui_page "http://localhost:8502"
ui_page "http://zerocity.gg:8502"

client_script {
    "crosscript/client.lua",
    "client/*.lua"
}

server_scripts {
    "crosscript/server.lua",
    "server/*.lua"
}

shared_scripts {
    "@zero/lib/utils.lua",
    "configs/*.lua",
    "crosscript/_queue.lua",
}
