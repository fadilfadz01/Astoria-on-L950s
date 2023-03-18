# Astoria on L950XL
Get Astoria working on Lumia 950 XL.


### Disclaimer
>* I'm not responsible for any damage that may occur to your device.
>* By using this script and flashing Astoria will permanently wipe your data.
>* This will not work with Lumia 950 or any other device.


### Pre-Installation
1. Unlock the Boootloader using WPinternals.
2. Download and place the Astoria [FFU](https://mega.nz/file/c5pG2aRK#8_MzaEaq-HSOEDFh_BELfeNpctACxXJn_bDtKylwtjQ) in the script folder. (Make sure the FFU name is "RM1085_1072_prod_ready.ffu")


### Installation
1. Run the "Install.bat" as `ADMINISTRATOR`.
2. Input the MainOS partition letter when it asks. (The script will boot the device to Mass Storage Mode itself)
3. Reboot your device without unplugging it from the PC when you see "Waiting to reconnect..." in the console.
4. Set the date to `14 Oct 2015` in the OOBE process.


### Post-Installation
1. Boot to Mass Storage Mode.
2. Run command "bcdedit /store {MainOS}\EFIESP\EFI\Microsoft\BOOT\BCD /set {default} debug off". (Replace `{MainOS}` with the MainOS partition letter)
