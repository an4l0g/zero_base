@echo off

set BASE_PATH=

cd %BASE_PATH%\pm2
call zero_hud.bat
cd %BASE_PATH%\pm2
call zero_inventory.bat
cd %BASE_PATH%\pm2
call zero_creation.bat
cd %BASE_PATH%\pm2
<<<<<<< HEAD
call zero_dynamic.bat
=======
call zero_production.bat
>>>>>>> cf9b27ca08a7b25026b4c9ec394ebbaa5f04496c

echo [zero_base] Todas as NUIs foram iniciadas
pause