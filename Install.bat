@echo off
"%~dp0"thor2.exe -mode uefiflash -ffufile "%~dp0RM1085_1072_prod_ready.ffu"
if %errorlevel% neq 0 pause&exit
"%~dp0"WPinternals\WPinternals.exe -FlashPartition EFIESP "%~dp0EFIESP.bin"
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
if %errorlevel% neq 0 pause&exit
xcopy /cey "%~dp0System32" "%MainOS%\Windows\System32\"
if %errorlevel% neq 0 pause&exit
"%~dp0"Windbg\kd.exe -k usb:targetname=WOATARGET
pause
exit