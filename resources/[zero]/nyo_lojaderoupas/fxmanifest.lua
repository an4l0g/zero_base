
fx_version 'adamant'
game 'gta5'


ui_page 'nui/ui.html'
files {
    'nui/ui.html',
    'nui/ui.css',
    'nui/ui.js',
    'nui/fonts/big_noodle_titling-webfont.woff',
    'nui/fonts/big_noodle_titling-webfont.woff2',
    'nui/fonts/pricedown.ttf',
}

client_script {
    "@zero/lib/utils.lua",
    "nyo_lojaderoupas_cfg.lua",
    "nyo_lojaderoupas_cl.lua"
}

server_scripts{
    "@zero/lib/utils.lua",
    "nyo_lojaderoupas_sv.lua"
}
              