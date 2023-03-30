@echo off
cls

set backup_path=%UserProfile%\Desktop\driver_yedek
md "%backup_path%"

echo Yedekleme işlemi başlatılıyor...
dism /online /export-driver /destination:"%backup_path%"

echo Sıkıştırma işlemi başlatılıyor...
set zip_path=%UserProfile%\Desktop\driver_yedek.zip
if exist "%zip_path%" del "%zip_path%"

REM Winget ile 7zip kurulumu yapılıyor
winget install 7zip.7zip

REM 7zip kurulumunu bekleyin
timeout 10

REM Kurulum sonrası 7zip'in bulunduğu dizinde sıkıştırma işlemi yapılıyor
"%ProgramFiles%\7-Zip\7z.exe" a -tzip "%zip_path%" "%backup_path%\*.*" -r
rd /s /q "%UserProfile%\Desktop\driver_yedek" > nul 2>&1
echo İşlem tamamlandı!
pause
