@echo off
chcp 65001 > nul
color 1F
title Windows Sürücü Geri Yükleme Programı

echo Bu program sürücü geri yükleme işlemi yapacak.
echo İşlem başlatılsın mı? (E/H)
set /p choice=

if /i "%choice%"=="E" (
    echo İşlem başlatılıyor...
    echo Lütfen bekleyin...
) else (
    echo İşlem iptal edildi.
    goto end
)

echo.
echo Yönetici haklarıyla çalıştığınızdan emin olunuz!
pause

echo.
echo Sürücü geri yükleme klasörü oluşturuluyor...
md "C:\import-drivers"

echo.
echo Zip dosyası açılıyor...
set /p zip_file=Zip dosyasının tam yolunu girin: 
tar -xf "%zip_file%" -C "C:\import-drivers"

echo.
echo Sürücüler yükleniyor...
for /r "C:\import-drivers" %%a in (*.inf) do (
    pnputil.exe /add-driver "%%a" /install
)

echo.
echo İşlem tamamlandı! Sürücüler yüklendi.

echo Sürücü geri yükleme klasörleri siliniyor...
rd /s /q "C:\import-drivers" > nul 2>&1
rd /s /q "C:\export-drivers" > nul 2>&1
:end
:end
echo Program kapatılıyor...
timeout /t 2 >nul
echo Bilgisayarınızın yeniden başlatılması gerekiyor.
echo 15 saniye içinde otomatik olarak yeniden başlatılacaktır.
shutdown /r -t 15
