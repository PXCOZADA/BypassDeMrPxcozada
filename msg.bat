@echo off
:: Este es el MessageBox que pregunta
echo MsgBox "Selecciona modo: SI=Bypass, NO=Panel/Legal", 36, "Configurador" > temp.vbs
for /f "tokens=*" %%a in ('cscript //nologo temp.vbs') do set res=%%a
del temp.vbs

:: 6 es SI (Bypass), 7 es NO (Panel)
set "fps=240"
if "%res%"=="6" set "fps=60"

:: Modificar el archivo (usando powershell por ser mas estable)
powershell -Command "$p='C:\ProgramData\BlueStacks_nxt\bluestacks.conf'; (Get-Content $p) -replace 'bst.instance.Pie64.max_fps=.*', 'bst.instance.Pie64.max_fps=\"%fps%\"' | Set-Content $p"
exit