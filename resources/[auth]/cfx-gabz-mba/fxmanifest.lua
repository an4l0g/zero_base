shared_script '@likizao_ac/client/library.lua'

fx_version 'cerulean'
game 'gta5'
author 'Gabz'
description 'Maze Bank Arena'
version '1.0.1'
lua54 'yes'
this_is_a_map 'yes'

dependencies { 
    '/server:4960',     -- ⚠️PLEASE READ⚠️; Requires at least SERVER build 4960.
    '/gameBuild:2545',  -- ⚠️PLEASE READ⚠️; Requires at least GAME build 2545.
}

data_file 'TIMECYCLEMOD_FILE' 'gabz_timecycle_mba.xml'

files {
    'gabz_timecycle_mba.xml',
}

client_script {
    "gabz_entityset_mba.lua"
}

escrow_ignore {
    'stream/**/*.ytd',
    'mba_doorlock.lua',
    'gabz_entityset_mba.lua',
}
dependency '/assetpacks'