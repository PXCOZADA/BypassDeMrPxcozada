@echo off
:inicio
:: Esperar a que el emulador se abra
tasklist | findstr /i "HD-Player.exe" >nul
if %errorlevel% equ 0 (
    :: Espera un poco a que cargue el emulador
    timeout /t 5 >nul
    :: Ejecuta tu archivo de mensaje
    call "C:\Program Files\BlueStacks_nxt\BypassDeMrPxcozada\msg.bat"
    :: Esperar a que cierren el emulador para volver a vigilar
    :esperar_cierre
    tasklist | findstr /i "HD-Player.exe" >nul
    if %errorlevel% equ 0 timeout /t 2 >nul & goto esperar_cierre
)
timeout /t 2 >nul
goto inicio