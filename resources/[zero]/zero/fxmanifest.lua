fx_version "bodacious"
game "gta5"

ui_page "nui/index.html"
ui_page_preload "yes"

loadscreen_manual_shutdown "yes"
loadscreen "loading/index.html"

client_scripts { 'client-side/*.lua' }
server_scripts { 
    'base.lua',
    'queue.lua',
    'server-side/*.lua' 
}
shared_scripts { "lib/utils.lua", 'cfg/*.lua' }

files { "nui/*", "lib/**/*", "loading/**/*" }              