:: zero_inventory
set nui_name="zero_inventory"
set nui_path="C:\zero_base\server-data\resources\[zero]\zero_inventory\nui"
set nui_path_build="C:\zero_base\server-data\resources\[zero]\zero_inventory\nui\dist"
set nui_port=8502

call pm2 delete %nui_name% --silent

:: buildando
cd %nui_path%
call yarn build

:: iniciando processo
call pm2 serve %nui_path_build% -s --name %nui_name% --port %nui_port%
