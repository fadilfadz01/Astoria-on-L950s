# Astoria on L950s
Get Astoria working on Lumia 950s.


### Disclaimer
>* I'm not responsible for any damage that may occur to your device.
>* By using this script and flashing Astoria will permanently wipe your data.
>* This will not work with any other devices.


### Pre-Installation
1. Unlock the Boootloader using [WPinternals](https://github.com/ReneLergner/WPinternals/tree/master/WPinternals).
2. Download and place the Astoria [FFU](https://mega.nz/folder/p0gFQT7R#_3aRCm8smFMUumArqnjNdQ) to the script folder.
3. Rename the FFU to "flash.ffu".


### Installation
1. Run the "Install.bat" as `ADMINISTRATOR`.
2. Select your device model from the console list.

	`Note: In case your deice boots into a blue screen, force reboot your device without unplugging it from the PC.`

3. Input the `MainOS` partition letter when it asks. (The script will boot the device to Mass Storage Mode itself)
4. Reboot your device without unplugging it from the PC when you see "Waiting to reconnect..." in the console.
5. Once the device is booted, set the date to `14 Oct 2015` in the OOBE setup process.


### Post-Installation
1. Boot to Mass Storage Mode.
2. Run command in the CMD, "bcdedit /store {MainOS}\EFIESP\EFI\Microsoft\BOOT\BCD /set {default} debug off". (Replace `{MainOS}` with the MainOS partition letter)
3. Reboot.
