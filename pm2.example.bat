@echo off

set BASE_PATH=C:\Users\Administrator\Documents\zero_PRODUCAO\server-data

cd %BASE_PATH%\pm2
call zero_appearance.bat
cd %BASE_PATH%\pm2
call zero_creation.bat
cd %BASE_PATH%\pm2
call zero_dynamic.bat
cd %BASE_PATH%\pm2
call zero_garage.bat
cd %BASE_PATH%\pm2
call zero_hospital.bat
cd %BASE_PATH%\pm2
call zero_hud.bat
cd %BASE_PATH%\pm2
call zero_identity.bat
cd %BASE_PATH%\pm2
call zero_inventory.bat
cd %BASE_PATH%\pm2
call zero_org.bat
cd %BASE_PATH%\pm2
call zero_production.bat
cd %BASE_PATH%\pm2
call zero_spawn.bat

echo [zero_base] Todas as NUIs foram iniciadas
pause