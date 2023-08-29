:: zero_spawn
set nui_name="zero_spawn"
set nui_path=%BASE_PATH%\resources\[zero]\zero_spawn\nui
set nui_path_build=%BASE_PATH%\resources\[zero]\zero_spawn\nui\dist
set nui_port=8510

call pm2 delete %nui_name% --silent

:: buildando
cd %nui_path%
call yarn install
cd %nui_path%
call yarn build

:: iniciando processo
call pm2 serve %nui_path_build% -s --name %nui_name% --port %nui_port%
