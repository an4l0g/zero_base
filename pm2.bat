@echo off

set BASE_PATH=C:\Users\an4log\Desktop\zero_base\server-data

cd %BASE_PATH%\pm2
call zero_hud.bat
cd %BASE_PATH%\pm2
call zero_inventory.bat
cd %BASE_PATH%\pm2
call zero_creation.bat
cd %BASE_PATH%\pm2
call zero_dynamic.bat

echo [zero_base] Todas as NUIs foram iniciadas
pause