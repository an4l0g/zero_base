fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'Likizão#4542'
description 'a really anticheat.'
url 'https://discord.gg/2SSfDCUVUj'

server_scripts {
    '@zero/lib/utils.lua',
    'server/bridge.js',
    'config/config.lua',
    'server/server.lua',
}

client_scripts {
    '@zero/lib/utils.lua',
    'client/client.lua',
    'client/library.lua',
}

files {    
    "ui/bundle.js",
    "ui/index.html"
}
ui_page "ui/index.html"

--                                                    ~
--  /$$       /$$$$$$ /$$   /$$ /$$$$$$ /$$$$$$$$  /$$$$$$   /$$$$$$ 
-- | $$      |_  $$_/| $$  /$$/|_  $$_/|_____ $$  /$$__  $$ /$$__  $$
-- | $$        | $$  | $$ /$$/   | $$       /$$/ | $$  | $$| $$  | $$
-- | $$        | $$  | $$$$$/    | $$      /$$/  | $$$$$$$$| $$  | $$
-- | $$        | $$  | $$  $$    | $$     /$$/   | $$__  $$| $$  | $$
-- | $$        | $$  | $$|  $$   | $$    /$$/    | $$  | $$| $$  | $$
-- | $$$$$$$$ /$$$$$$| $$ |  $$ /$$$$$$ /$$$$$$$$| $$  | $$|  $$$$$$/
-- |________/|______/|__/  |__/|______/|________/|__/  |__/ |______/ #4542
        