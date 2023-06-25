:: zero_production
set nui_name="zero_production"
set nui_path=%BASE_PATH%\resources\[zero]\zero_production\nui
set nui_path_build=%BASE_PATH%\resources\[zero]\zero_production\nui\dist
set nui_port=8506

call pm2 delete %nui_name% --silent

:: buildando
cd %nui_path%
call yarn install
cd %nui_path%
call yarn build

:: iniciando processo
call pm2 serve %nui_path_build% -s --name %nui_name% --port %nui_port%
