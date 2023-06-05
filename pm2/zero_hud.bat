:: zero_hud
set nui_name="zero_hud"
set nui_path="C:\Users\an4log\Desktop\zero_base\server-data\resources\[zero]\zero_hud\nui"
set nui_path_build="C:\Users\an4log\Desktop\zero_base\server-data\resources\[zero]\zero_hud\nui\dist"
set nui_port=8501

call pm2 delete %nui_name% --silent

:: buildando
cd %nui_path%
call yarn build

:: iniciando processo
call pm2 serve %nui_path_build% -s --name %nui_name% --port %nui_port%
