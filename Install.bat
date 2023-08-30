@echo off
title Astoria on L950s
echo Get Astoria working on L950s
echo https://github.com/fadilfadz01/Astoria-on-L950s
echo.
echo Select the device model [1/2]
echo 1. Lumia 950 XL
echo 2. Lumia 950
choice /n /c 12 /m "> "
if errorlevel 2 set device=Talkman&goto continue
if errorlevel 1 set device=Cityman&goto continue
:continue
echo.
"%~dp0"thor2.exe -mode uefiflash -ffufile "%~dp0flash.ffu"
if %errorlevel% neq 0 pause&exit
if %device% == Cityman ("%~dp0"WPinternals\WPinternals.exe -FlashCustomROM "%~dp0Devices\%device%\EFIESP.zip") else ("%~dp0"WPinternals\WPinternals.exe -FlashCustomROM "%~dp0Devices\%device%\EFIESP.zip")
if %errorlevel% neq 0 pause&exit
"%~dp0"WPinternals\WPinternals.exe -EnableTestSigning
if %errorlevel% neq 0 pause&exit
"%~dp0"WPinternals\WPinternals.exe -SwitchToMassStorageMode
if %errorlevel% neq 0 pause&exit
:Retry
echo Enter MainOS letter (Eg: D:\)
set /p "MainOS=> "
if not exist "%MainOS%\EFIESP" goto Retry
if not exist "%MainOS%\DATA" goto Retry
if not exist "%MainOS%\DPP" goto Retry
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\BOOT\BCD" /deletevalue {bootmgr} customactions
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\BOOT\BCD" /deletevalue {bootmgr} custom:54000001
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\BOOT\BCD" /deletevalue {bootmgr} custom:54000002
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\BOOT\BCD" /deletevalue {bootmgr} custom:54000003
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\BOOT\BCD" /set {bootmgr} displaybootmenu on
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\BOOT\BCD" /set {bootmgr} timeout 30
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\BOOT\BCD" /set {bootmgr} displayorder "{default}" "{0d1b5e40-42f1-41e7-a690-8dd3ce23cc11}"
bcdedit /store "%MainOS%\EFIESP\EFI\Microsoft\BOOT\BCD" /set {default} debug on
reg load HKLM\LSOFTWARE "%MainOS%\Windows\System32\Config\SOFTWARE"
reg add HKLM\LSOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock /v AllowDevelopmentWithoutDevLicense /t REG_DWORD /d 1 /f
reg add HKLM\LSOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock /v AllowAllTrustedApps /t REG_DWORD /d 1 /f
reg add HKLM\LSOFTWARE\Microsoft\Windows\CurrentVersion\DeviceUpdate\Agent\Settings /v GuidOfCategoryToScan /t REG_SZ /d 00000000-0000-0000-0000-000000000000 /f
reg unload HKLM\LSOFTWARE
if not exist "%MainOS%\Windows\Packages\registryFiles\OEMSettings.reg" goto Skip
attrib -s "%MainOS%\Windows\Packages\registryFiles\OEMSettings.reg"
ren "%MainOS%\Windows\Packages\registryFiles\OEMSettings.reg" "OEMSettings.gz"
"%~dp07za.exe" e "%MainOS%\Windows\Packages\registryFiles\OEMSettings.gz" -o"%MainOS%\Windows\Packages\registryFiles\"
cmd /u /c echo.>>"%MainOS%\Windows\Packages\registryFiles\OEMSettings"
cmd /u /c echo>>"%MainOS%\Windows\Packages\registryFiles\OEMSettings" [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock]
cmd /u /c echo>>"%MainOS%\Windows\Packages\registryFiles\OEMSettings" "AllowAllTrustedApps"=dword:00000001
cmd /u /c echo>>"%MainOS%\Windows\Packages\registryFiles\OEMSettings" "AllowDevelopmentWithoutDevLicense"=dword:00000001
cmd /u /c echo.>>"%MainOS%\Windows\Packages\registryFiles\OEMSettings"
cmd /u /c echo>>"%MainOS%\Windows\Packages\registryFiles\OEMSettings" [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceUpdate\Agent\Settings]
cmd /u /c echo>>"%MainOS%\Windows\Packages\registryFiles\OEMSettings" "GuidOfCategoryToScan"="00000000-0000-0000-0000-000000000000"
"%~dp07za.exe" u "%MainOS%\Windows\Packages\registryFiles\OEMSettings.gz" "%MainOS%\Windows\Packages\registryFiles\OEMSettings"
ren "%MainOS%\Windows\Packages\registryFiles\OEMSettings.gz" "OEMSettings.reg"
attrib +s "%MainOS%\Windows\Packages\registryFiles\OEMSettings.reg"
del "%MainOS%\Windows\Packages\registryFiles\OEMSettings"
:Skip
xcopy /cey "%~dp0System32" "%MainOS%\Windows\System32\"
if %device% == Cityman xcopy /cey "%~dp0Devices\Cityman\Config" "%MainOS%\Windows\System32\Config\"
if %errorlevel% neq 0 pause&exit
echo Keep the phone connected to the PC.
echo You can disconnect once the phone booted to the OS.
echo Reboot the phone manually by pressing and holding the power-button of the phone for about 10 seconds until it vibrates.
"%~dp0"Windbg\kd.exe -k usb:targetname=WOATARGET
pause
exit