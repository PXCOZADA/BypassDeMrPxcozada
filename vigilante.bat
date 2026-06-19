@echo off
:loop
tasklist | findstr /i "HD-Player.exe" >nul
if %errorlevel% equ 0 (
    call msg.bat
    :: Esperar a que el emulador se cierre para no molestar
    :wait
    tasklist | findstr /i "HD-Player.exe" >nul
    if %errorlevel% equ 0 timeout /t 5 >nul & goto wait
)
timeout /t 2 >nul
goto loop